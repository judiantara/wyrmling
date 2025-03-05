{hostname, inputs, outputs, lib, config, pkgs, ...}:
{
  imports = [
     ../../hardware/tlp.nix
     ../../hardware/bluetooth.nix
     ./disk.nix
     ./luks.nix
  ];
}
