{ pkgs, ... }:

{
  imports = let
    deviceName = "Meatlug";
  in [
    ../../hardware/cpu-intel.nix
    ../../hardware/network-scanner.nix
    ../../hardware/keyboard.nix
    ../../hardware/bluetooth.nix
    ../../hardware/auto-cpufreq.nix
    ../../config/bootloader.nix
    ../../config/system.nix
    ../../config/system-packages.nix
    ../../config/networkmanager.nix
    ../../config/systemd-resolved.nix
    ../../config/network-extrahosts.nix
#     ../../config/console-disabled.nix
    ../../config/sleep-disabled.nix
    ../../config/zsh.nix
    ../../config/ssh.nix
    ../../config/ssl.nix
    ../../config/ca-certificates.nix
    ../../config/pipewire-audio.nix
    ../../config/age-encryption.nix
    ../../config/git.nix
    ../../config/flatpak.nix
    ../../config/firewall/kdeconnect.nix
    ../../config/firewall/mac-winbox.nix
    ../../config/firewall/syncthing.nix
    ../../users/judiantara
    (import ../../config/disk/efi-luks-btrfs.nix    { name = "${deviceName}"; device = "/dev/disk/by-id/ata-INTEL_SSDSCKKF128G8L_BTLA75000T93128I"; })
    (import ../../config/disk/swap-btrfs-subvol.nix { name = "${deviceName}"; size   = "8G"; })
    (import ../../config/luks-device.nix            { name = "${deviceName}"; })
    (import ../../config/tpm-boot.nix               { name = "${deviceName}"; })
  ];

  boot = {
    initrd.availableKernelModules = [
      "ahci"
      "xhci_pci"
      "usbhid"
      "usb_storage"
      "sd_mod"
      "sdhci_pci"
      "rtsx_pci_sdmmc"
    ];
    blacklistedKernelModules = [
      "elan_i2c"
    ];
  };

  # eanble openvpn plugin
  networking.networkmanager.plugins = [ pkgs.networkmanager-openvpn ];
}
