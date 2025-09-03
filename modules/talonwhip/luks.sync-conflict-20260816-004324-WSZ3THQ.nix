{ lib, pkgs, hostname, ... }:

{
  boot = {
    initrd = {
      systemd.enable = lib.mkForce true;  # initrd uses systemd

      kernelModules = [
          "usbhid"
      ];

      services.udev.packages = with pkgs; [
        libfido2
        yubikey-personalization
      ];

      luks = let
        devicename = lib.strings.toSentenceCase hostname;
      in {
        # Support for Yubikey PBA
        yubikeySupport = false; # because systemd
        fido2Support = false;   # because systemd
        devices.${devicename} = {
          device = "/dev/disk/by-partlabel/${devicename}";
          keyFile = "/dev/disk/by-id/usb-UDISK_PDU01_2G_65A2.0_0000000000005D-0:0";
          crypttabExtraOpts = [
            "keyfile-size=1024"
            "keyfile-offset=2048"
            "keyfile-timeout=60s"
          ];
        };
      };
    };

    loader.timeout = lib.mkForce 1;
  };

  services.udev.packages = with pkgs; [
    libfido2
    yubikey-personalization
  ];

  environment.systemPackages = with pkgs; [
    systemd
    libfido2
    cryptsetup
  ];
}
