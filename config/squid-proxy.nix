{ ... }:

{
  services.squid = {
    enable = true;
    proxyAddress = "0.0.0.0";
  };

  # Open port for harmonia
  networking.firewall.allowedTCPPorts = [ 3128 ];
}
