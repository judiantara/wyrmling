{ lib, ... }:

{
  options = {
    users.judiantara.home-manager.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
    users.judiantara.syncthing-nm-dispatcher.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };
}
