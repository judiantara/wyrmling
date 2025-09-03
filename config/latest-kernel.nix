{ pkgs, ... }:

{
  # Latest linux kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.extraModulePackages = [ ];

  #initrd
  boot.initrd = {
    availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "uas" "sd_mod" ];

    # Required to open the EFI partition and Yubikey
    kernelModules = ["vfat" "nls_cp437" "nls_iso8859-1" "usbhid"];

    #enable systemd on bootloader stage 1
    systemd.enable = true;
  };

  # Use systemd-boot as bootloader
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    timeout = 3;
  };
}
