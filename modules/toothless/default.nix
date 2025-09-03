{ user, ... }:

{
  imports = [
    ../../hardware/cpu-amd.nix
    ../../hardware/sane.nix
    ../../hardware/printers.nix
    ../../hardware/keyboard.nix
    ../../hardware/usbip.nix
    ../../config/system.nix
    ../../config/system-packages.nix
    ../../config/console-disabled.nix
    ../../config/disable-sleep.nix
    ../../config/default-user.nix
    ../../config/plasma-desktop.nix
    ../../config/networkmanager.nix
    ../../config/zsh.nix
    ../../config/ssh.nix
    ../../config/ssl.nix
    ../../config/dns.nix
    ../../config/ca-certificates.nix
    ../../config/pipewire-audio.nix
    ../../config/age-encryption.nix
    ../../config/kdeconnect.nix
    ../../config/syncthing.nix
    ../../config/git.nix
    ../../config/nix-cache-proxy.nix
    ../../users/${user}
    ./disk.nix
    ./luks.nix
  ];
}
