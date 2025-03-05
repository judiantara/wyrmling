{lib, config, pkgs, user, hostname, ...}:
{
  environment.systemPackages = with pkgs; [
    php84
    php84Packages.composer
  ];

  services.caddy = {
    enable = true;
    globalConfig = ''
      http_port 8080
      https_port 8443
    '';
  };

  services.phpfpm.phpOptions = ''
    session.cookie_lifetime=0
    session.use_cookies=On
    session.use_only_cookies=On
    session.use_strict_mode=On
    session.cookie_httponly=On
    session.cookie_secure=On
    session.use_trans_sid=Off
  '';

  services.phpfpm.pools.${hostname} = {
    user = "${user}";
    phpPackage = pkgs.php84;
    settings = {
      "listen.owner"         = config.services.caddy.user;
      "pm"                   = "dynamic";
      "pm.max_children"      = 32;
      "pm.max_requests"      = 500;
      "pm.start_servers"     = 2;
      "pm.min_spare_servers" = 2;
      "pm.max_spare_servers" = 5;
    };
  };

  networking.firewall.allowedTCPPorts = [8080 8443];
}
