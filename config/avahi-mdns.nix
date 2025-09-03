{ lib, ... }:

{
  services.resolved = {
    extraConfig = lib.concatLines [
      "MulticastDNS=no"
    ];
  };

  # handle mDNS using avahi
  services.avahi = {
    enable       = true;
    openFirewall = true;
    nssmdns4     = true;
    ipv6         = false;
    publish = {
      enable       = true;
      domain       = true;
      addresses    = true;
      workstation  = true;
      userServices = true;
    };
  };
}
