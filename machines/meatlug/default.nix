{hostname, inputs, outputs, lib, config, pkgs, ...}:
{
  imports = [
     ../../hardware/amd.nix
     ../../hardware/keyboard.nix
     ../../hardware/tlp.nix
     ../../hardware/bluetooth.nix
     ../../config/system.nix
     ../../config/latest-kernel.nix
     ../../config/virtualbox.nix
     ../../users/u2f-pam.nix
     ../../users/judiantara.nix
     ./disk.nix
     ./luks.nix
  ];
}
