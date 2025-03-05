{ config, pkgs, lib, ... }:

{
  users.users.judiantara = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK6G07AT9uNhUY7adp58KvhKfWajWOJNLIArqOfzlxG5 Baju Judiantara"
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIMPE5alD1Q4iICcUg3Wl7s041izdVSYmDCJqBZiPzO4RAAAABHNzaDo= Baju Judiantara YubiKey"
    ];
  };

  security.pam.services = {
    login.u2fAuth = true;
    sudo.u2fAuth = true;
  };

  security.pam.u2f = {
    enable = true;
    settings = {
      interactive = true;
      cue = true;
      origin = "pam://judiantara";
      authfile = pkgs.writeText "u2f-mappings" (lib.concatStrings [
        "judiantara"
        ":109FkKJZKKEPF1GajCaFGthy+3HEw2nSvNg+GDTWhD6bI7rzTQReIZr/kvF9Ad9Yems9m1Ok+NomXuEo3lbRTw==,AqzN0UfJcfJ7ftpNcKW3K+c+cFuo5LTkMoWHmEVVU9+UWr3HBF3yCGdOzjJGS3d8R8/6+CyrCb5ZekgTIda4Cg==,es256,+presence"
        ":mViLIld/gHpiim6lgd3eb8jq8721dI7ZzXLLD4KjxvehAHJJr/mpfQj2MU/bK4ayH2o6UzIB5D2a7K2qQOwBCg==,CY281JRWMpcT9l1hZPbNvqq5gkPARheZh6rniZmb1Cse4+nmrXdxS0mt95VEEzMyUscQOoOohZSWyd5R5ftD9Q==,es256,+presence"
      ]);
    };
  };

  # open syncthing
  networking.firewall = {
    allowedTCPPorts = [ 8384 22000 ];
    allowedUDPPorts = [ 22000 21027 ];
  };
}
