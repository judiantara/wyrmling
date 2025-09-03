{ self, lib, ... }:
{
  imports = [
    ../../config/system.nix
    ../../config/user.nix
    ../../config/addy.nix
    ../../config/php.nix
    ../../config/mariadb.nix
    ../../config/redis.nix
    ../../config/openvscode-server.nix
    ../../config/network-extrahosts.nix
    ../../config/git.nix
  ]
  ++ lib.optional (builtins.pathExists (self + "/configuration.nix")) (self + "/configuration.nix");
}
