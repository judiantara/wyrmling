{ user, ... }:

{
  imports = [
    ../../hardware/amd.nix
    ../../hardware/keyboard.nix
    ../../hardware/tlp.nix
    ../../hardware/bluetooth.nix
    ../../config/system.nix
    ../../config/system-packages.nix
    ../../config/bootloader.nix
    ../../config/plasma-desktop.nix
    ../../config/networkmanager.nix
    ../../config/systemd-resolved.nix
    ../../config/avahi-mdns.nix
    ../../config/network-extrahosts.nix
    ../../config/ssh.nix
    ../../config/ssl.nix
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
