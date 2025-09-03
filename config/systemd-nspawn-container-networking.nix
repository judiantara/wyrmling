{ MACAddress, ...}:

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
}
