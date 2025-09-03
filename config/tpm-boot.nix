{ hostname, pkgs, config, ... }:

{
  environment.systemPackages = let
    device = config.boot.initrd.luks.devices.${hostname}.device;

    sys-tpm-boot = pkgs.writeShellScriptBin "sys-tpm-boot" ''

      set -euo pipefail

      if [[ $EUID -ne 0 ]]; then
        echo "Please run as root"
        exit 1
      fi

      systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=0+2+12 --wipe-slot=tpm2 ${device}
      echo "Rebooting now..."
      sleep 3
      reboot
    '';
  in [
    sys-tpm-boot
  ];
}
