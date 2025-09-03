{ lib, ... }:

{
  boot.initrd = {
    systemd.enable = lib.mkForce true;  # initrd uses systemd

    luks = {
      # Support for Yubikey PBA
      yubikeySupport = false; # because systemd
      fido2Support = false;   # because systemd
      devices."tigress" = {
        device = "/dev/disk/by-partlabel/tigress";
        crypttabExtraOpts = ["fido2-device=auto"];  # cryptenroll
      };
    };
  };
}
