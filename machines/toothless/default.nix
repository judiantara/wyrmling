{hostname, inputs, outputs, lib, config, pkgs, ...}:
{
  imports = [
    ../../hardware/amd.nix
    ../../hardware/keyboard.nix
    ../../config/system.nix
    ../../config/default-packages.nix
    ../../config/default-user.nix
    ../../config/latest-kernel.nix
    ../../config/plasma-desktop.nix
    ../../config/networkmanager.nix
    ../../config/ssh.nix
    ../../config/ssl.nix
    ../../config/dns.nix
    ../../config/pipewire-audio.nix
    ../../config/age-encryption.nix
    ../../config/kdeconnect.nix
    ../../config/git.nix
    ../../users/${user}.nix
    ./disk.nix
    ./luks.nix
  ];
}
