{ hostname, ... }:

{
  users.groups.ssl = {};

  age = {
    secrets = {
      "host-cert-bundle.pem" = {
        file  = ../vault + builtins.toPath "/${hostname}/${hostname}-cert-bundle.pem.age";
        path  = "/etc/ssl/certs/host-cert-bundle.pem";
        mode  = "440";
        group = "ssl";
      };

      "host-cert.pem" = {
        file  = ../vault + builtins.toPath "/${hostname}/${hostname}-cert.pem.age";
        path  = "/etc/ssl/certs/host-cert.pem";
        mode  = "440";
        group = "ssl";
      };

      "host-key.pem" = {
        file  = ../vault + builtins.toPath "/${hostname}/${hostname}-cert-key.pem.age";
        path  = "/etc/ssl/certs/host-key.pem";
        mode  = "440";
        group = "ssl";
      };
    };
  };
}
