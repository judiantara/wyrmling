{ ... }:

{
  boot.initrd = {
    systemd.enable = true;  # initrd uses systemd
    luks = {
      # Support for Yubikey PBA
      yubikeySupport = false; # because systemd
      fido2Support = false;   # because systemd
      devices."rumbletail" = {
        device = "/dev/disk/by-partlabel/Rumbletail";
        crypttabExtraOpts = ["fido2-device=auto"];  # cryptenroll
      };
    };
  };
}
