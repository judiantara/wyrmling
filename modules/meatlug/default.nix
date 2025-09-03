{ user, ... }:

{
  imports = [
    ../../hardware/cpu-intel.nix
    ../../hardware/network-scanner.nix
    ../../hardware/keyboard.nix
    ../../hardware/bluetooth.nix
    ../../hardware/auto-cpufreq.nix
    ../../config/bootloader.nix
    ../../config/tpm-boot.nix
    ../../config/system.nix
    ../../config/system-packages.nix
    ../../config/networkmanager.nix
    ../../config/systemd-resolved.nix
    ../../config/network-extrahosts.nix
    ../../config/zram-swap.nix
    ../../config/console-disabled.nix
    ../../config/sleep-disabled.nix
    ../../config/plasma-desktop.nix
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
    ../../users/${user}
    ./disk.nix
    ./luks.nix
#     ./tlp.nix
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

  # Recommended for Intel CPUs to prevent overheating
  services.thermald.enable = true;
}
