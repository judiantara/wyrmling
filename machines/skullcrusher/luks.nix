{ ... }:

{
  boot.initrd = {
    luks = {
      # Support for Yubikey PBA
      yubikeySupport = true;

      devices."skullcrusher" = {
        device = "/dev/disk/by-partlabel/SkullCrusher";
        fallbackToPassword = true;
      };
    };
  };
}
