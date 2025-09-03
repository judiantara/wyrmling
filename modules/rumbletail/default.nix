{ user, ... }:

{
  imports = [
    ../../hardware/cpu-intel.nix
    ../../hardware/network-scanner.nix
    ../../hardware/printers.nix
    ../../hardware/keyboard.nix
    ../../hardware/bluetooth.nix
    ../../hardware/tlp.nix
    ../../config/bootloader.nix
    ../../config/tpm-boot.nix
    ../../config/system.nix
    ../../config/system-packages.nix
    ../../config/networkmanager.nix
    ../../config/systemd-resolved.nix
    ../../config/network-extrahosts.nix
    ../../config/zram-swap.nix
    ../../config/console-disabled.nix
    ../../config/sleep-disabled.nix
    ../../config/plasma-desktop.nix
    ../../config/zsh.nix
    ../../config/ssh.nix
    ../../config/ssl.nix
    ../../config/ca-certificates.nix
    ../../config/pipewire-audio.nix
    ../../config/age-encryption.nix
    ../../config/git.nix
    ../../config/firewall/kdeconnect.nix
    ../../config/firewall/syncthing.nix
    ../../users/${user}
    ./disk.nix
    ./luks.nix
  ];
}
