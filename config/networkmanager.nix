{ lib, ... }:

{
  # Use NetworkManager to manage networking instead of systemd-networkd
  systemd.network = {
    enable = lib.mkForce false;
    wait-online.enable = lib.mkForce false;
  };

  systemd.services.NetworkManager-wait-online.enable = lib.mkForce true;

  networking = {
    # Enable NetworkManager
    networkmanager = {
      enable = lib.mkForce true;

      # let systemd-resolved completely manage dns resolution
      dns = lib.mkForce "none";
      settings = {
        main = {
          systemd-resolved = "false";
        };
      };
    };

    # Enable firewall.
    firewall.enable = lib.mkForce true;

    #disable IPv6
    enableIPv6 = lib.mkForce false;

    nameservers = lib.mkForce [
      "192.168.240.1"
    ];
  };
}
