{ lib, hostname, ... }:

{
  boot.initrd = {
    systemd.enable = lib.mkForce true;  # initrd uses systemd

    luks = {
      # Support for Yubikey PBA
      yubikeySupport = lib.mkForce false; # because systemd
      fido2Support = lib.mkForce false;   # because systemd

      devices.${hostname} = {
        device = "/dev/disk/by-partlabel/Stormfly";
        crypttabExtraOpts = ["fido2-device=auto"];  # cryptenroll
      };
    };
  };
}
