{ ... }:

{
  imports = let
    deviceName = "Tigress";
  in [
    ../../hardware/cpu-intel.nix
    ../../hardware/bluetooth.nix
    ../../hardware/network-scanner.nix
    ../../hardware/network-printers.nix
    ../../config/bootloader.nix
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
    ../../users/iswarini
    (import ../../config/disk-partition.nix { name = "${deviceName}"; device =  "/dev/sda"; })
    (import ../../config/disk-swap.nix      { name = "${deviceName}"; size   =  "32G"; })
    (import ../../config/luks-device.nix    { name = "${deviceName}"; })
    (import ../../config/tpm-boot.nix       { name = "${deviceName}"; })
  ];

  boot = {
    initrd.availableKernelModules = [
      "xhci_pci"
      "ehci_pci"
      "ahci"
      "usbhid"
      "usb_storage"
      "sd_mod"
#       "sr_mod"
    ];
    blacklistedKernelModules = [];
  };

  programs.kdeconnect.enable = true;
}
