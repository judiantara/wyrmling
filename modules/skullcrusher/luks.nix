{ lib, ... }:

{
  boot.initrd = {
    systemd.enable = lib.mkForce true;  # initrd uses systemd

    luks = {
      # Support for Yubikey PBA
      yubikeySupport = lib.mkForce false; # because systemd
      fido2Support = lib.mkForce false;   # because systemd

      devices."skullcrusher" = {
        device = "/dev/disk/by-partlabel/SkullCrusher";
        crypttabExtraOpts = ["fido2-device=auto"];  # cryptenroll
      };
    };
  };
}
