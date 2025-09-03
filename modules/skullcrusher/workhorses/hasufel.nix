{ hostname, ... }:

let
  name = "hasufel";
in
{
  services.nginx.virtualHosts."${name}.${hostname}.opik" = {
    serverName        = "${name}.${hostname}.opik";
    sslCertificate    = "/etc/ssl/certs/host-cert.pem";
    sslCertificateKey = "/etc/ssl/certs/host-key.pem";
    forceSSL          = true;

    locations."/".extraConfig = ''
      proxy_pass http://${name}.opik:3000;
      proxy_set_header Host $host;
      proxy_redirect http:// https://;
      proxy_http_version 1.1;
      proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
      proxy_set_header Upgrade $http_upgrade;
      proxy_set_header Connection $connection_upgrade;
    '';
  };
}
