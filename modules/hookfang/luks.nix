{ ... }:

{
  boot.initrd = {
    systemd.enable = true;  # initrd uses systemd
    luks = {
      # Support for Yubikey PBA
      yubikeySupport = false; # because systemd
      fido2Support = false;   # because systemd
      devices."hookfang" = {
        device = "/dev/disk/by-partlabel/hookfang"; # Be sure to update this to the correct volume
        crypttabExtraOpts = ["fido2-device=auto"];  # cryptenroll
      };
    };
  };
}
