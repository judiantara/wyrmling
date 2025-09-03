{ MACAddress, lib, ... }:

{
  # Use systemd-networkd to manage networking instead of NetworkManager
  systemd.network.networks."10-lan" = {
    matchConfig.Name    = "host0";
    networkConfig.DHCP  = "yes";

    linkConfig = {
      MTUBytes = "1500";
      MACAddress = "${MACAddress}";
    };
  };

  networking = {
    # Disable NetworManager
    networkmanager.enable = lib.mkForce false;

    # Disable dhcpcd
    useDHCP = lib.mkForce false;

    # Enable systemd-networkd
    useNetworkd = lib.mkForce true;

    # Enable firewall.
    firewall.enable = lib.mkForce true;

    # Disable IPv6
    enableIPv6 = lib.mkForce false;
  };

  # Use systemd-networkd to manage networking instead of NetworkManager
  systemd.network = {
    enable = lib.mkForce true;
    wait-online = {
      enable = lib.mkForce true;
      extraArgs = [
        "--any"
      ];
    };
  };
}
