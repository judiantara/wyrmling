{ ... }:
{
  # open port for impress remote
  networking.firewall = {
    allowedUDPPorts = [ 1598 1599 ];
  };
}
