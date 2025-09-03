{ user, ... }:

{
  imports = [
    ../../hardware/cpu-amd.nix
    ../../hardware/sane.nix
    ../../hardware/printers.nix
    ../../hardware/keyboard.nix
    ../../hardware/bluetooth.nix
    ../../hardware/tlp.nix
    ../../config/system.nix
    ../../config/system-packages.nix
    ../../config/default-user.nix
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
    ../../config/syncthing.nix
    ../../config/git.nix
    ../../config/flatpak.nix
    ../../users/${user}.nix
    ./disk.nix
    ./luks.nix
  ];
}
