{hostname, inputs, outputs, lib, config, pkgs, ...}:
{
  imports = [
    ../../config/system.nix
    ../../config/user.nix
    ../../config/addy.nix
    ../../config/php.nix
    ../../config/mariadb.nix
    ../../config/redis.nix
    ../../config/openvscode-server.nix
    ../../config/git.nix
  ];
}
