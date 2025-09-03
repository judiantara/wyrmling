{ pkgs, lib, config, ... }:

{
  security.pam.services = lib.mkIf (config.security.u2f.enable) {
    login.u2fAuth = true;
    sudo.u2fAuth = true;
  };

  #
  # enroll u2f keys with command
  # pamu2fcfg -o pam://judiantara -i pam://judiantara
#   #
  security.pam.u2f = lib.mkIf (config.security.u2f.enable) {
    enable = true;
    settings = {
      interactive = true;
      cue = true;
      origin = "pam://judiantara";
      authfile = pkgs.writeText "u2f-mappings" (lib.concatStrings [
        "judiantara"
        ":6fEVt9/C594Ii7D7S/6JJifTsA0DrRjaZLuoJx2fknY0IvpQ9uOzHphw5dzCRVub/445uXM7+6RpSOJbb9vO5w==,vNeL2KR7vXjeHSOBTMZCuVRCjWM/AmOd9zXsFEHOKYhp6189sMK4klxQylvIIJCs3c8MYA97B2g1++jqcQS6cA==,es256,+presence"
        ":GzDTETgQ+4iNbu+KqGeTHM+7A4DDcfkbANMfCWc+0FvsGhZXV+9HPY/c4PgBKa8nQy4nCeXT0C+sW63vMvqcQw==,6Khxu5rkiDIIWkDB1tLE7bY4YeE+XLzKYVcI3H5TgX2ryrVVFCFW6taxjZ/A/IcawT2zpEV+2WD4iR6YQ2NeeQ==,es256,+presence"
      ]);
    };
  };
}
