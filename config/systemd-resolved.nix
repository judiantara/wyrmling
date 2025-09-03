{ ... }:

{
  # Enable systemd-resolved for DNS resolution
  services.resolved = {
    enable      = true;
    domains     = [ "~." ];
    dnssec      = "allow-downgrade";
    dnsovertls  = "opportunistic";
    llmnr       = "false";
    fallbackDns = [
      "1.1.1.3"
      "1.0.0.3"
    ];
  };

  # open firewall for mDNS
  networking.firewall = {
    allowedUDPPorts = [ 5353 ];
  };
}
