{ hostname, ... }:

{
  age = {
    secrets = {
      "host-cert-bundle.pem" = {
        file = ../vault + builtins.toPath "/${hostname}/${hostname}-cert-bundle.pem.age";
        path = "/etc/ssl/certs/host-cert-bundle.pem";
        mode = "444";
      };

      "host-cert.pem" = {
        file = ../vault + builtins.toPath "/${hostname}/${hostname}-cert.pem.age";
        path = "/etc/ssl/certs/host-cert.pem";
        mode = "444";
      };

      "host-key.pem" = {
        file = ../vault + builtins.toPath "/${hostname}/${hostname}-cert-key.pem.age";
        path = "/etc/ssl/certs/host-key.pem";
        mode = "444";
      };
    };
  };
}
