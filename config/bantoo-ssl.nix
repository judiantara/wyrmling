{hostname, inputs, outputs, lib, config, pkgs, ...}:
{
  # restore host ssh keys
  environment ={
    etc = {
      "ssl/certs/bantoo-cert-bundle.pem".source = "/nix/persist/etc/ssl/bantoo-cert-bundle.pem";
      "ssl/certs/bantoo-cert-key.pem".source    = "/nix/persist/etc/ssl/bantoo-cert-key.pem";
      "ssl/certs/bantoo-cert.pem".source        = "/nix/persist/etc/ssl/bantoo-cert.pem";
    };
  };
}
