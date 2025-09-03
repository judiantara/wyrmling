{ ... }:

{
  boot.initrd = {
    luks = {
      # Support for Yubikey PBA
      yubikeySupport = false;

      devices."skullcrusher" = {
        device = "/dev/disk/by-partlabel/SkullCrusher";
      };
    };
  };
}
