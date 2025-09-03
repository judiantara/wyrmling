{ lib, modulesPath, config, user, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ../../hardware/cpu-intel.nix
    ../../hardware/bluetooth.nix
    ../../hardware/printers.nix
    ../../config/bootloader.nix
    ../../config/tpm-boot.nix
    ../../config/system.nix
    ../../config/system-packages.nix
    ../../config/networkmanager.nix
    ../../config/systemd-resolved.nix
    ../../config/zram-swap.nix
    ../../config/sleep-disabled.nix
    ../../config/zsh.nix
    ../../config/ssh.nix
    ../../config/ssl.nix
    ../../config/ca-certificates.nix
    ../../config/pipewire-audio.nix
    ../../config/age-encryption.nix
    ../../config/firewall/kdeconnect.nix
    ../../users/${user}
    ./disk.nix
    ./luks.nix
  ];

  boot = {
    initrd.availableKernelModules = [
      "xhci_pci"
      "ehci_pci"
      "ahci"
      "usb_storage"
      "sd_mod"
#       "sr_mod"
    ];
    blacklistedKernelModules = [];
  };

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # Recommended for Intel CPUs to prevent overheating
  services.thermald.enable = true;

  programs.kdeconnect.enable = true;
}
