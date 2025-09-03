{ lib, ... }:

{
  networking = {
    useDHCP = lib.mkForce true;

    # Disable NetworManager
    networkmanager.enable = lib.mkForce false;

    # Enable firewall.
    firewall.enable = true;
  };
}
