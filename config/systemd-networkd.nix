{hostname, inputs, outputs, lib, config, pkgs, ...}:
{
  networking = {
    useDHCP = lib.mkForce true;

    # Enable networking
    networkmanager.enable = lib.mkForce false;

    # Enable firewall.
    firewall.enable = true;
  };
}
