{ ... }:

{
  imports = let
    deviceName = "Toothless";
  in [
    ../../hardware/cpu-amd.nix
    ../../hardware/network-printers.nix
    ../../hardware/network-scanner.nix
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
    ../../config/zsh.nix
    ../../config/ssh.nix
    ../../config/ssl.nix
    ../../config/ca-certificates.nix
    ../../config/pipewire-audio.nix
    ../../config/age-encryption.nix
    ../../config/git.nix
    ../../config/firewall/kdeconnect.nix
    ../../config/firewall/syncthing.nix
    ../../users/judiantara

    (import ../../config/disk-partition.nix { name = "${deviceName}"; device =  "/dev/disk/by-id/nvme-MidasForce_SSD_256GB_AA000000000000000966_1"; })
    (import ../../config/luks-device.nix    { name = "${deviceName}"; })
    (import ../../config/tpm-boot.nix       { name = "${deviceName}"; })
  ];
}
