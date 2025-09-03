{ lib, ... }:

{
  services.resolved = {
    enable      = lib.mkForce true;
    domains     = lib.mkForce [ "~." ];
    dnssec      = lib.mkForce "false";
    dnsovertls  = lib.mkForce "false";
    fallbackDns = lib.mkForce [
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
    nssmdns4     = lib.mkForce true;
    ipv6         = lib.mkForce false;
    publish = {
      enable = lib.mkForce true;
      domain = lib.mkForce true;
      addresses = lib.mkForce true;
      workstation = lib.mkForce true;
      userServices = lib.mkForce true;
    };
  };
}
