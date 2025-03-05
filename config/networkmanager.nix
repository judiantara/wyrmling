{hostname, inputs, outputs, lib, config, pkgs, ...}:
{
  networking = {
    # Enable networking
    networkmanager.enable = true;

    # Enable firewall.
    firewall.enable = true;
  };
}
