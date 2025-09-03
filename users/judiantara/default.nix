{ pkgs, config, hostname, user, ... }:

{
  imports = [
    ../../config/default-user.nix
#   ./ssh-public-key.nix
    ./yubikey-u2f.nix
  ];

  environment.systemPackages = let
    run_gc      = ''1 -eq "$do_delete"'';
    do_gc       = "${pkgs.nix}/bin/nix-collect-garbage -d";
    flake       = "${pkgs.nix}/bin/nix flake";
    hm          = "${pkgs.home-manager}/bin/home-manager";
    hm_switch   = "${hm} switch -b backup";
    show_gens   = "${hm} generations";
    rage        = "${pkgs.rage}/bin/rage";
    identityKey = "/etc/ssh/ssh_host_ed25519_key";
    dotConfig   = ../../vault + builtins.toPath "/${hostname}/${hostname}-home-${user}.tar.xz.age";
    userHome    = "${config.users.users.${user}.home}";
    userId      = "${toString config.users.users.${user}.uid}";
    my-update   = pkgs.writeShellScriptBin "my-update" ''

      set -euo pipefail

      function usage {
      cat >&2 <<EOF
      my-update - reconfigure ${user}'s home-manager

      Usage: my-update [-d] [--delete-old]

      Options:
        -d, --delete-old  Delete old home-manager configurations
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

      if [[ ${userId} -ne $EUID ]]; then
        echo "Please run as user ${user}"
        exit 1
      fi

      if [[ -e ${identityKey} && -e ${dotConfig} ]]; then
        echo "Extracting essential configuration"
        /run/wrappers/bin/sudo ${rage} --decrypt --identity ${identityKey} ${dotConfig} | ${pkgs.gnutar}/bin/tar -xpJC ${userHome}
        echo
      fi

      echo "Downloading new home-manager configuration"
      if [ ! -e ${userHome}/.config/home-manager/flake.nix ]; then
        ${flake} new --refresh --template git+ssh://github.com/judiantara/casitas#${user}@${hostname} ${userHome}/.config/home-manager/
      else
        ${flake} update --flake ${userHome}/.config/home-manager/
      fi

      echo
      echo "Applying new home-manager configuration"
      ${hm_switch}

      if [[ ${run_gc} ]]; then
        echo "Removing home-manager old configurations"
        ${do_gc}
        nix-store --optimize
        echo
      fi

      echo "Current home-manager configuration"
      ${show_gens}
    '';
  in with pkgs; [
    home-manager
    my-update
  ];
}
