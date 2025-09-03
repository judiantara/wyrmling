{ pkgs, lib, config, ... }:

{
  boot = lib.mkIf (! config.boot.isContainer) {
    # Use latest linux kernel
    kernelPackages = pkgs.linuxPackages_latest;

    tmp.useTmpfs = lib.mkForce true;

    kernel.sysctl = {
      "kernel.printk" = "2 4 1 7";
    };

    extraModulePackages = [ ];

    initrd = {
      #enable systemd on bootloader stage 1
      systemd.enable = true;

      availableKernelModules = [
        "nvme"
        "xhci_pci"
        "ahci"
        "usbhid"
        "usb_storage"
        "uas"
        "sd_mod"
      ];

      # Required to open the EFI partition and Yubikey
      kernelModules = [
        "vfat"
        "nls_cp437"
        "nls_iso8859-1"
        "usbhid"
      ];
    };

    loader = {
      grub.enable = lib.mkForce false;

      generic-extlinux-compatible.enable = lib.mkForce false;

      # user systemd-boot as bootloader
      systemd-boot = {
        enable = lib.mkForce true;
        consoleMode = "5";
      };
      efi.canTouchEfiVariables = true;
      timeout = 3;
    };
  };
}
