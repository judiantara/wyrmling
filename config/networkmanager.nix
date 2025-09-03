{ lib, ... }:

{
  # Use NetworkManager to manage networking instead of systemd-networkd
  systemd.network.enable = lib.mkForce false;

  networking = {
    # Enable NetworkManager
    networkmanager.enable = lib.mkForce true;

    # Enable firewall.
    firewall.enable = lib.mkForce true;

    #disable IPv6
    enableIPv6 = lib.mkForce false;
  };
}
