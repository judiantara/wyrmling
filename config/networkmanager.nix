{ lib, ... }:

{
  networking = {
    # Enable networking
    networkmanager.enable = lib.mkForce true;

    # Enable firewall.
    firewall.enable = lib.mkForce true;

    #disable IPv6
    enableIPv6 = lib.mkForce false;
  };
}
