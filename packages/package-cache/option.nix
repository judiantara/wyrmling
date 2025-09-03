{ lib, ... }:

{
  options = {
    system.nixos.nix-use-cache = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };
}
