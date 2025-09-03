{ hostname, ... }:

{
  services.ncps = {
    enable = true;
    cache = {
      hostName = "cache.${hostname}.opik";
      maxSize = "150G";
      lru.schedule = "0 2 * * *"; # Clean up daily at 2 AM
      allowPutVerb = true;
      allowDeleteVerb = true;
    };
    server.addr = "127.0.0.1:5000";
    upstream = {
      caches = [
        "https://cache.nixos.org"
      ];
      publicKeys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      ];
    };
  };

  services.nginx.virtualHosts."cache.${hostname}.opik" = {
    serverName        = "cache.${hostname}.opik";
    sslCertificate    = "/etc/ssl/certs/host-cert.pem";
    sslCertificateKey = "/etc/ssl/certs/host-key.pem";
    forceSSL          = true;

    locations."/".extraConfig = ''
      proxy_pass http://127.0.0.1:5000;
      proxy_set_header Host $host;
      proxy_http_version 1.1;
      proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
      proxy_set_header Upgrade $http_upgrade;
      proxy_set_header Connection $connection_upgrade;
    '';
  };
}
