{ user, ... }:

{
  imports = let
    deviceName = "Toothless";
  in [
    ../../hardware/cpu-amd.nix
    ../../hardware/network-scanner.nix
    ../../hardware/network-printers.nix
    ../../hardware/keyboard.nix
    ../../config/bootloader.nix
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

    (import ../../config/tpm-boot.nix    { deviceName = "${deviceName}"; })
    (import ../../config/nvme-disk.nix   { deviceName = "${deviceName}"; })
    (import ../../config/luks-device.nix { deviceName = "${deviceName}"; })
  ];
}
