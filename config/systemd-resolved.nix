{ ... }:

{
  # Enable systemd-resolved for DNS resolution
  services.resolved = {
    enable = true;
    settings.Resolve = {
      Domains     = [ "~." ];
      NDDSEC      = "allow-downgrade";
      DNSOverTLS  = "opportunistic";
      LLMR        = "false";
      FallbackDNS = [
        "1.1.1.3"
        "1.0.0.3"
      ];
    };
  };

  # open firewall for mDNS
  networking.firewall.allowedUDPPorts = [ 5353 ];
}
