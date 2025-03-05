{ config, pkgs, lib, ... }:

{
  age.secrets = {
    homelab-tls-cert.file = ./homelab-tls-cert.age;
    homelab-tls-key.file = ./homelab-tls-key.age;
  };
}
