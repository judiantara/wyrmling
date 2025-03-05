{hostname, inputs, outputs, lib, config, pkgs, ...}:
{
  imports = [
    ./disk.nix
    ./kernel.nix
    ./system.nix
    ./packages.nix
    ./user.nix
    ./tls.nix
    ./caddy.nix
    ./php.nix
    ./mariadb.nix
    ./redis.nix
    ./openvscode-server.nix
    ./git.nix
  ];
}
