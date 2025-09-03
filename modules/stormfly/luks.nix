{ ... }:

{
  boot.initrd = {
    luks = {
      # Support for Yubikey PBA
      yubikeySupport = false;

      devices."stormfly" = {
        device = "/dev/disk/by-partlabel/StormFly";
      };
    };
  };
}
