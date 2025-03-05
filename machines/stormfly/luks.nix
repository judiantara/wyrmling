{ config, lib, pkgs, modulesPath, ... }:

{
  boot.initrd = {
    availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "uas" "sd_mod" ];
    # Required to open the EFI partition and Yubikey
    kernelModules = ["vfat" "nls_cp437" "nls_iso8859-1" "usbhid"];

    luks = {
      # Support for Yubikey PBA
      yubikeySupport = false;

      devices."stormfly" = {
        device = "/dev/disk/by-partlabel/Stormfly";
        fallbackToPassword = true;
      };
    };
  };
}
