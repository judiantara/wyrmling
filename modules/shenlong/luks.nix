{ ... }:

{
  boot.initrd = {
    systemd.enable = true;  # initrd uses systemd
    luks = {
      # Support for Yubikey PBA
      yubikeySupport = false; # because systemd
      fido2Support = false;   # because systemd
      devices."shenlong" = {
        device = "/dev/disk/by-partlabel/shenlong";
        crypttabExtraOpts = ["fido2-device=auto"];  # cryptenroll
      };
    };
  };
}
