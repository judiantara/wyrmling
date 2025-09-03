{ lib, config, ... }:

{
  options = {
    security.u2f.enable = lib.mkOption {
      type = lib.types.bool;
      default = (! config.boot.isContainer);
    };
  };
}
