{ hostname, lib, config, inputs, pkgs, ... }:

{
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

  # Opinionated: solely use flake instead of nix channels
  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";

      # Opinionated: disable global registry
      #flake-registry = "";

      # Workaround for https://github.com/NixOS/nix/issues/9574
      nix-path = config.nix.nixPath;
    };
    # Opinionated: disable channels
    channel.enable = false;

    # Opinionated: make flake registry and nix path match flake inputs
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  networking.hostName = lib.mkForce "${hostname}";

  # Set your time zone.
  time.timeZone = "Asia/Jakarta";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_IDENTIFICATION = "id_ID.UTF-8";
      LC_MEASUREMENT    = "id_ID.UTF-8";
      LC_ADDRESS        = "id_ID.UTF-8";
      LC_MONETARY       = "id_ID.UTF-8";
      LC_NAME           = "id_ID.UTF-8";
      LC_NUMERIC        = "id_ID.UTF-8";
      LC_PAPER          = "id_ID.UTF-8";
      LC_TELEPHONE      = "id_ID.UTF-8";
      LC_TIME           = "id_ID.UTF-8";
    };
  };

  # use memory safe sudo implementation
  security.sudo.enable = lib.mkForce false;
  security.sudo-rs = {
    enable = true;
    execWheelOnly = false;
  };

  environment.variables = {
    EDITOR="nano";
  };

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  environment.systemPackages = let
    sys-update = pkgs.writeShellScriptBin "sys-update" ''

      set -euo pipefail

      function usage {
      cat >&2 <<EOF
      sys-update - reconfigure this NixOS machine

      Usage: sys-update [-h] [--hostname] <hostname> || [-d] [--delete-old]

      Options:
        -d, --delete-old  Delete old NixOS configuration generations
        -H, --hostname    Set hostname during first update
        -h, --help        Show this help

      EOF
      }

      # Get CLI options
      opts=$(getopt -n "sys-update" -o "h,d,H:" -l "help,delete-old,hostname:" -- "$@")

      # Inspect CLI options
      eval set -- "$opts"

      do_delete=0
      host=
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
          -H|--hostname)
            host="$2"
            shift 2
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

      if [[ $EUID -ne 0 ]]; then
        echo "Please run as root"
        exit 1
      fi

      if [[ ! -e /etc/nixos/flake.nix ]]; then
        if [[ -z ''${host:-} ]]; then
          echo "System not configured yet, please provide hostname"
          exit 1
        fi
        if  [[ 1 -eq "$do_delete" ]]; then
          echo "System not configured yet"
          exit 1
        fi

        if [[ "${toString config.boot.isContainer}" ]]; then
          rm -f /etc/machine-id
        fi

        nix flake new --refresh --template github:judiantara/wyrmling#$host /etc/nixos/
        nixos-rebuild boot --flake /etc/nixos#$host
        reboot
      else
        nix flake update --flake /etc/nixos/
        nixos-rebuild switch --flake /etc/nixos#${hostname}

        if [[ "$do_delete" -eq 1 ]]; then
          nix-collect-garbage -d
          nixos-rebuild boot --flake /etc/nixos#${hostname}
          reboot
        else
          echo
          echo "NixOS Generations"
          nixos-rebuild list-generations
          if [[ ! "${toString config.boot.isContainer}" ]]; then
            echo
            echo "NixOS Boot entries"
            ls -l /boot/loader/entries
          fi
        fi
      fi
    '';
  in with pkgs; [
    nano
    wget
    curl
    gnumake
    home-manager
    sys-update
  ];
}
