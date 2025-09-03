{ ... }:

let
    snihostname = "workhorse";
in
{
  age = {
    secrets = {
      "${snihostname}-cert-bundle.pem" = {
        file = ../vault + builtins.toPath "/${snihostname}/${snihostname}-cert-bundle.pem.age";
        path = "/etc/ssl/certs/${snihostname}-cert-bundle.pem";
        mode = "444";
      };

      "${snihostname}-cert.pem" = {
        file = ../vault + builtins.toPath "/${snihostname}/${snihostname}-cert.pem.age";
        path = "/etc/ssl/certs/${snihostname}-cert.pem";
        mode = "444";
      };

      "${snihostname}-key.pem" = {
        file = ../vault + builtins.toPath "/${snihostname}/${snihostname}-cert-key.pem.age";
        path = "/etc/ssl/certs/${snihostname}-key.pem";
        mode = "444";
      };
    };
  };
}
