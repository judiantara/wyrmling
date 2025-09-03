{ lib, ... }:

{
  options = {
    services.usbip.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };
}
