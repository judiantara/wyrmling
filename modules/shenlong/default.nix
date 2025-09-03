{ user, ... }:

{
  imports = [
    ../../hardware/amd.nix
    ../../hardware/keyboard.nix
    ../../hardware/tlp.nix
    ../../hardware/bluetooth.nix
    ../../config/system.nix
    ../../config/system-packages.nix
    ../../config/latest-kernel.nix
    ../../config/plasma-desktop.nix
    ../../config/networkmanager.nix
    ../../config/ssh.nix
    ../../config/ssl.nix
    ../../config/dns.nix
    ../../config/pipewire-audio.nix
    ../../config/yubikey.nix
    ../../config/age-encryption.nix
    ../../config/kdeconnect.nix
    ../../config/git.nix
    ../../config/virtualbox-host.nix
    ../../users/${user}.nix
    ./disk.nix
    ./luks.nix
  ];
}
