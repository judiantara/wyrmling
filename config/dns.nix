{inputs, outputs, lib, config, pkgs, ...}:
{
#   networking.nameservers = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];

  services.resolved = {
    enable      = true;
    domains     = [ "~." ];
    dnssec      = "false";
    dnsovertls  = "false";
    fallbackDns = [
      "1.1.1.3"
      "1.0.0.3"
    ];
  };
}
