{ lib, ... }:

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
    extraConfig = lib.concatLines [
      "MulticastDNS=no"
    ];
  };

  # open firewall for LLMR and mDNS
  networking.firewall = rec {
    allowedTCPPorts = [ 5353 5355 ];
    allowedUDPPorts = allowedTCPPorts;
  };

  # handle mDNS using avahi
  services.avahi = {
    enable       = lib.mkForce true;
    openFirewall = lib.mkForce true;
    nssmdns4     = true;
    ipv6         = false;
    publish = {
      enable = true;
      domain = true;
      addresses = true;
      workstation = true;
      userServices = true;
    };
  };
}
