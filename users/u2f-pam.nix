{ config, pkgs, lib, ... }:

{
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
}
