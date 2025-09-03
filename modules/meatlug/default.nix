{ user, ... }:

{
  imports = [
    ../../hardware/cpu-amd.nix
    ../../hardware/sane.nix
    ../../hardware/printers.nix
    ../../hardware/keyboard.nix
    ../../hardware/bluetooth.nix
    ../../hardware/tlp.nix
    ../../config/disable-console.nix
    ../../config/system.nix
    ../../config/system-packages.nix
    ../../config/default-user.nix
    ../../config/latest-kernel.nix
    ../../config/plasma-desktop.nix
    ../../config/zsh.nix
    ../../config/ssh.nix
    ../../config/ssl.nix
    ../../config/dns.nix
    ../../config/ca-certificates.nix
    ../../config/pipewire-audio.nix
    ../../config/yubikey.nix
    ../../config/age-encryption.nix
    ../../config/kdeconnect.nix
    ../../config/syncthing.nix
    ../../config/git.nix
    ../../config/flatpak.nix
    ../../config/podman.nix
    ../../config/mikrotik-winbox.nix
    ../../users/${user}.nix
    ./disk.nix
    ./luks.nix
    ./networking.nix
    ./workhorses.nix
  ];
}
