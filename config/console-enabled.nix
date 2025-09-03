{ lib, ... }:

{
  imports = [
    ../hardware/console.nix
  ];

  console.enable = lib.mkForce true;
}
