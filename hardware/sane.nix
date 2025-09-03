{ user, lib, ... }:

{
  hardware.sane = {
    enable = true;
    netConf = lib.concatLines [
      "talonwhip.opik"
    ];
  };

  users.users.${user}.extraGroups = [
    "scanner"
    "lp"
  ];
}
