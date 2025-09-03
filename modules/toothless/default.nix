{ user, ... }:

{
  imports = [
    ../../hardware/cpu-amd.nix
    ../../hardware/sane.nix
    ../../hardware/printers.nix
    ../../hardware/keyboard.nix
    ../../config/bootloader.nix
    ../../config/system.nix
    ../../config/system-packages.nix
    ../../config/zram-swap.nix
    ../../config/console-disabled.nix
    ../../config/sleep-disabled.nix
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
    ../../users/${user}
    ./disk.nix
    ./luks.nix
  ];
}
