{ ... }:

{
  services.nginx = {
    enable = true;
    recommendedTlsSettings = true;
  };

  # Open port for nginx reverse proxy
  networking.firewall.allowedTCPPorts = [ 443 ];
}
