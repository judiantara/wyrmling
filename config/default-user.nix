{ user, hostname, pkgs, config, ... }:

{
  nix.settings.trusted-users = [
    "${user}"
  ];

  users.groups.${user} = {
    gid = 1000;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    hashedPassword = "*";
    isNormalUser = true;
    home = "/home/${user}";
    createHome = true;
    group = "${user}";
    uid = 1000;
    extraGroups = [
      "wheel"
      "systemd-journal"
      "networkmanager"
      "vboxusers"
      "kvm"
    ];
  };

  security.sudo-rs.extraRules = [
    {
      users = [ "${user}" ];
      commands = [
         {
           command = "ALL" ;
           options= [ "NOPASSWD" ];
         }
      ];
    }
  ];

  environment.systemPackages = let
    my-update = pkgs.writeShellScriptBin "my-update" ''

      set -euo pipefail

      function usage {
      cat >&2 <<EOF
      my-update - reconfigure ${user}'s home-manager

      Usage: my-update [-d] [--delete-old]

      Options:
        -d, --delete-old  Delete old home-manager configuration generations
        -h, --help        Show this help
      EOF
      }

      # Get CLI options
      opts=$(getopt -n "my-update" -o "h,d" -l "help,delete-old" -- "$@")

      # Inspect CLI options
      eval set -- "$opts"

      do_delete=0
      while true; do
        case $1 in
          -h|--help)
            usage
            exit 0
          ;;
          -d|--delete-old)
            do_delete=1
            shift 1
          ;;
          --)
            shift
            break
          ;;
          *)
            echo "FATAL: THIS SHOULD NOT HAPPEN!!!"
            echo "Argument [$1] not recognized"
            exit 2
          ;;
        esac
      done

      if [[ ${toString config.users.users.${user}.uid} -ne $EUID ]]; then
        echo "Please run as user ${user}"
        exit 1
      fi

      if [ ! -e /home/${user}/.config/home-manager/flake.nix ]; then
        if [[ "$do_delete" -eq 1 ]]; then
          echo "home-manager not initialized yet"
          exit 1
        fi

        nix flake new --refresh --template git+ssh://github.com/judiantara/casitas#${user}@${hostname} /home/${user}/.config/home-manager/
        home-manager switch -b backup
        echo
        home-manager generations
      else
        nix flake update --flake /home/${user}/.config/home-manager/
        home-manager switch
        if [[ "$do_delete" -eq 1 ]]; then
          nix-collect-garbage -d
        fi
        echo
        home-manager generations
      fi
    '';
  in [
    my-update
  ];
}
