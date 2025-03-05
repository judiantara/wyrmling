{ config, pkgs, lib, ... }:

{
  age.secrets = {
    tls-cert-host = {
      file  = ./tls-cert-host.age;
      mode  = "440";
      group = "wheel";
    };
    tls-key-host = {
      file  = ./tls-key-host.age;
      mode  = "440";
      group = "wheel";
    };
    tls-cert-syncthing = {
      file  = ./tls-cert-syncthing.age;
      mode  = "440";
      group = "wheel";
    };
    tls-key-syncthing = {
      file  = ./tls-key-syncthing.age;
      mode  = "440";
      group = "wheel";
    };
  };
}
