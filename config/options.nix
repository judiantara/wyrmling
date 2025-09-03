{ lib, ... }:

{
  # add any user defined config options here
  imports = [
    ../packages/u2f/option.nix
    ../packages/usbipd/option.nix
    ../packages/package-cache/option.nix
  ];

  options.installation.flavor = lib.mkOption {
    type = lib.types.enum [ "gui" "tui" ];
    default = "gui";
  };
}
