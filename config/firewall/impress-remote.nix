{ ... }:
{
  # open port for impress remote
  networking.firewall = rec {
    allowedUDPPorts = [ 1598 1599 ];
    allowedTCPPorts = allowedUDPPorts;
  };
}
