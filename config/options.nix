{ ... }:

{
  # add any user defined config options here
  imports = [
    ../packages/u2f/option.nix
    ../packages/usbipd/option.nix
    ../packages/package-cache/option.nix
  ];
}
