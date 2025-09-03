{ config, lib, ... }:

let
  user = "judiantara";
in {
  age = {
    secrets = let
      configPath = "${config.users.users.${user}.home}/.config/ssh";
    in {
      "${user}-ssh-id" = {
        file  = ./vault/id_ed25519.age;
        path  = "${configPath}/id_ed25519";
        mode  = "400";
        owner = "${user}";
        group = "${user}";
        symlink = true;
      };

      "${user}-ssh-pub" = {
        file = ./vault/id_ed25519.pub.age;
        path  = "${configPath}/id_ed25519.pub";
        mode  = "444";
        owner = "${user}";
        group = "${user}";
        symlink = true;
      };

      "${user}-ssh-cert" = {
        file = ./vault/id_ed25519-cert.pub.age;
        path  = "${configPath}/id_ed25519-cert.pub";
        mode  = "444";
        owner = "${user}";
        group = "${user}";
        symlink = true;
      };
    };
  };

  services.openssh.extraConfig = lib.mkAfter ''
    Match User ${user}
      AcceptEnv *
  '';
}
