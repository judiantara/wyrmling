{ ... }:

{
  services.resolved = {
    enable      = true;
    domains     = [ "~." ];
    dnssec      = "false";
    dnsovertls  = "false";
    fallbackDns = [
      "1.1.1.3"
      "1.0.0.3"
    ];
    extraConfig = "MulticastDNS=no";
  };

  # open firewall for LLMR
  networking.firewall = {
    allowedTCPPorts = [ 5355 ];
    allowedUDPPorts = [ 5355 ];
  };

  services.avahi = {
    enable       = true;
    ipv6         = false;
    openFirewall = true;
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
    };
  };
}
