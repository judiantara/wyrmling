{ lib, ... }:

{
  options = {
    security.u2f.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };
}
