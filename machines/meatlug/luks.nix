{ config, lib, pkgs, modulesPath, ... }:

{
  boot.initrd = {
    availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "uas" "sd_mod" ];
    # Required to open the EFI partition and Yubikey
    kernelModules = ["vfat" "nls_cp437" "nls_iso8859-1" "usbhid"];

    luks = {
      # Support for Yubikey PBA
      yubikeySupport = true;

      devices."meatlug" = {
        device = "/dev/disk/by-partlabel/Meatlug"; # Be sure to update this to the correct volume
        fallbackToPassword = false;

        yubikey = {
          slot = 1;
          twoFactor = false; # Set to false for 1FA
          gracePeriod = 5; # Time in seconds to wait for Yubikey to be inserted
          keyLength = 64; # Set to $KEY_LENGTH/8
          saltLength = 16; # Set to $SALT_LENGTH

          storage = {
            device = "/dev/disk/by-partlabel/MeatlugESP"; # Be sure to update this to the correct volume
            fsType = "vfat";
            path = "/salt.conf";
          };
        };
      };
    };
  };
}
