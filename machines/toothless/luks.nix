{ ... }:

{
  boot.initrd = {
    luks = {
      # Support for Yubikey PBA
      yubikeySupport = false;

      devices."toothless" = {
        device = "/dev/disk/by-partlabel/Toothless";
      };
    };
  };
}
