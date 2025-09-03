{ pkgs, lib, config, ... }:

let
  myna-font = pkgs.callPackage ../packages/myna-font { inherit pkgs; };
in
{
  fonts = lib.mkIf (! config.boot.isContainer) {
    enableDefaultPackages = true;
    fontDir.enable = true;
    fontconfig = {
      enable = true;
      defaultFonts.monospace = [
        "Myna"
      ];
    };
    packages =  with pkgs; [
      myna-font
      hack-font
      fira-code-symbols
      nerd-fonts.fira-code
    ];
  };

  # set console font
  services.kmscon.fonts = lib.mkIf (config.services.kmscon.enable) [
    { name = "Myna"; package = myna-font; }
    { name = "Hack"; package = pkgs.hack-font; }
    { name = "Fira Code Symbol"; package = pkgs.fira-code-symbols; }
    { name = "FiraCode Nerd Font Mono"; package = pkgs.nerd-fonts.fira-code; }
  ];
}
