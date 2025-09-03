{ pkgs, lib, ... }:

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
        ":v2Kx4Xd/1zrcIxS+hhj4brKwBCmkhtyG0bctwKfouwJXToq2Rfn6z8fuN2LOTGH8c5pPGHQQOoHL6uwszF8+qA==,ip6RK4nxD5o2KaIxbNWIldrT21p7z33g1Xeri2v46zX/mD4Ps19NBxDez6d/NYTVAR7yRNiAV0kuv3QEEa04ow==,es256,+presence"
        ":lpWCizPQTNv4IJnzUrvTPzhhQP+URKLy6d3+o5qeyauFODIbysR8JE4icXo9usMHIpfCpPjaWmxw7P6vMIy8yQ==,eFdN/wJealU1WpHfTSSwVyipADk5dykTCrMGPOTpgj1glgO1A++5zil+fdT5TdLjQ5B9huWsCKOwqxRCSgBbWA==,es256,+presence"
        ":109FkKJZKKEPF1GajCaFGthy+3HEw2nSvNg+GDTWhD6bI7rzTQReIZr/kvF9Ad9Yems9m1Ok+NomXuEo3lbRTw==,AqzN0UfJcfJ7ftpNcKW3K+c+cFuo5LTkMoWHmEVVU9+UWr3HBF3yCGdOzjJGS3d8R8/6+CyrCb5ZekgTIda4Cg==,es256,+presence"
        ":mViLIld/gHpiim6lgd3eb8jq8721dI7ZzXLLD4KjxvehAHJJr/mpfQj2MU/bK4ayH2o6UzIB5D2a7K2qQOwBCg==,CY281JRWMpcT9l1hZPbNvqq5gkPARheZh6rniZmb1Cse4+nmrXdxS0mt95VEEzMyUscQOoOohZSWyd5R5ftD9Q==,es256,+presence"
      ]);
    };
  };
}
