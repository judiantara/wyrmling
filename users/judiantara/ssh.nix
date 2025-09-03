{ user, config, lib, ... }:

{
  age = {
    secrets = {
      "${user}-ssh-id" = {
        file  = ./vault/id_ed25519.age;
        path  = "${config.users.users.${user}.home}/.ssh/id_ed25519";
        mode  = "400";
        owner = "${user}";
        group = "${user}";
        symlink = true;
      };

      "${user}-ssh-pub" = {
        file = ./vault/id_ed25519.pub.age;
        path  = "${config.users.users.${user}.home}/.ssh/id_ed25519.pub";
        mode  = "444";
        owner = "${user}";
        group = "${user}";
        symlink = true;
      };

      "${user}-ssh-cert" = {
        file = ./vault/id_ed25519-cert.pub.age;
        path  = "${config.users.users.${user}.home}/.ssh/id_ed25519-cert.pub";
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

#   users.users.${user}.openssh.authorizedKeys.keys = [
#     "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK6G07AT9uNhUY7adp58KvhKfWajWOJNLIArqOfzlxG5 Baju Judiantara"
#   ];
}
