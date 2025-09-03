{ pkgs, config, hostname, user, ... }:

{
  imports = [
    ./yubikey-u2f.nix
    ./ssh-public-key.nix
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
        if [[ 1 -eq "$do_delete" ]]; then
          echo "home-manager not initialized yet, ignoring delete old generations"
        fi

        nix flake new --refresh --template git+ssh://github.com/judiantara/casitas#${user}@${hostname} /home/${user}/.config/home-manager/
        home-manager switch -b backup
        echo
        home-manager generations
      else
        nix flake update --flake /home/${user}/.config/home-manager/
        home-manager switch -b backup
        if [[ "$do_delete" -eq 1 ]]; then
          nix-collect-garbage -d
        fi
        echo
        home-manager generations
      fi
    '';
  in with pkgs; [
    home-manager
    my-update
  ];
}
