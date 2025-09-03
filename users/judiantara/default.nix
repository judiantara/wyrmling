{ pkgs, config, hostname, lib, ... }:

let
  user = "judiantara";
  fullname = "Baju Judiantara";
  uid = 1000;
in {
  imports = [
     (import ../../config/default-user.nix   { user = "${user}"; uid = uid; })
     (import ../../config/plasma-desktop.nix { user = "${user}"; uid = uid; })
    ./yubikey-u2f.nix
    ./ssh.nix
  ];

  users.users.${user} = {
    description = "${fullname}";
    extraGroups = [
      "wheel"
      "systemd-journal"
      "vboxusers"
      "kvm"
      "ssl"
    ];
  };

  systemd.tmpfiles.rules = [
    "d ${config.users.users.${user}.home}/.config 0755 ${user} ${user} - -"
    "Z ${config.users.users.${user}.home}/.config - ${user} ${user} - -"
  ];

  # use memory safe sudo implementation
  security = {
    sudo.enable = lib.mkForce false;
    sudo-rs = {
      enable = true;
      execWheelOnly = false;
      extraRules = [
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
    };
  };

  environment.systemPackages = let
    run_gc     = ''1 -eq "$do_delete"'';
    do_gc      = "${pkgs.nix}/bin/nix-collect-garbage -d";
    flake      = "${pkgs.nix}/bin/nix flake";
    hm         = "${pkgs.home-manager}/bin/home-manager";
    hm_switch  = "${hm} switch -b hmb";
    show_gens  = "${hm} generations";
    userHome   = "${config.users.users.${user}.home}";
    sshPath    = "${userHome}/.config/ssh";
    hmPath     = "${userHome}/.config/home-manager";
    userId     = "${toString config.users.users.${user}.uid}";
    backupPath = "/run/media/${user}/MyBackup/${hostname}/";

    my-backup = pkgs.writeShellScriptBin "my-backup" ''

      set -euo pipefail

      function usage {
      cat >&2 <<EOF
      my-backup - backup ${user}'s home directory to flashdisk

      Usage: my-backup

      Options:
        -h, --help        Show this help
      EOF
      }

      # Get CLI options
      opts=$(getopt -n "my-backup" -o "h" -l "help" -- "$@")

      # Inspect CLI options
      eval set -- "$opts"

      while true; do
        case $1 in
          -h|--help)
            usage
            exit 0
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

      if [[ ! -d "${backupPath}" ]]; then
        echo "Backup target directory [${backupPath}] does not exists";
        exit 1
      fi

      /run/wrappers/bin/sudo ${pkgs.rsync}/bin/rsync -aAXHv ${userHome}/ ${backupPath}
    '';

    my-update = pkgs.writeShellScriptBin "my-update" ''

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

      if [ ! -e ${sshPath}/config ]; then
        echo "Configuring SSH client"
        ${pkgs.coreutils-full}/bin/mkdir -p ${sshPath}
        ${pkgs.coreutils-full}/bin/chmod 700 ${sshPath}
        cat << 'EOF' > ${sshPath}/config
      Host *
        ServerAliveInterval 5
        ExitOnForwardFailure yes
        Compression yes
        IdentitiesOnly yes
        IdentityFile ${sshPath}/id_ed25519
        UserKnownHostsFile ${sshPath}/forge_hosts

      host github.com
        user git

      host gitlab.com
        user git
      EOF
        ${pkgs.coreutils-full}/bin/chmod 600 ${sshPath}/config
        ${pkgs.coreutils-full}/bin/rm -rf ${userHome}/.ssh
        ${pkgs.coreutils-full}/bin/ln -sf ${sshPath} ${userHome}/.ssh
      fi

      if [ ! -e ${sshPath}/forge_hosts ]; then
        echo "Configuring SSH server identification"
        cat << 'EOF' > ${sshPath}/forge_hosts
      github.com ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl
      gitlab.com ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAfuCHKVTjquxvt6CM6tdG4SLp1Btn/nOeHHE5UOzRdf
      EOF
      fi

      echo "Downloading new home-manager configuration"
      if [ ! -e ${hmPath}/flake.nix ]; then
        ${flake} new --refresh --template git+ssh://github.com/judiantara/casitas#judiantara@${hostname} ${hmPath}/
      else
        ${flake} update --flake ${hmPath}/
      fi

      echo
      echo "Applying new home-manager configuration"
      ${hm_switch}

      if [[ ${run_gc} ]]; then
        echo "Removing home-manager old configurations"
        ${do_gc}
        nix-store --optimize
        find ${userHome} -type f -name "*.hmb" -exec rm {} \;
        echo
      fi

      echo "Current home-manager configuration"
      ${show_gens}
    '';
  in with pkgs; [
    rsync
    home-manager
    my-update
    my-backup
  ];
}
