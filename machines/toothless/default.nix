{hostname, inputs, outputs, lib, config, pkgs, ...}:
{
  imports = [
    ./disk.nix
    ./luks.nix
  ];
}
