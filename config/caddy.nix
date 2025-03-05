{lib, config, pkgs, ...}:
{
  services.caddy = {
    enable = true;
    globalConfig = ''
      http_port 8080
      https_port 8443
    '';
    virtualHosts = {
      "ikut.bantu.yuk".extraConfig = ''
        tls /etc/ssl/certs/host-cert.pem /etc/ssl/certs/host-key.pem
        
        encode zstd gzip

        handle /api/* {
          root * /var/www/backend
          php_fastcgi unix/${config.services.phpfpm.pools.bantoo.socket}
        }

        handle {
          root * /var/www/frontend
          file_server
        }
      '';

      "edit.bantu.yuk".extraConfig = ''
        tls /etc/ssl/certs/host-cert.pem /etc/ssl/certs/host-key.pem        
        encode zstd gzip
        reverse_proxy localhost:3000
      '';
    };
  };

  networking.firewall.allowedTCPPorts = [ 80 443];
}
