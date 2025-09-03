{ lib, ... }:

{
  imports = let
    deviceName = "Talonwhip";
  in [
    ../../hardware/rpi4.nix
    ../../hardware/scanner.nix
    ../../hardware/printer-laserjet-1020.nix
    ../../hardware/network-scanner.nix
    ../../config/bootloader.nix
    ../../config/system.nix
    ../../config/systemd-networkd.nix
    ../../config/systemd-resolved.nix
    ../../config/network-extrahosts.nix
    ../../config/console-disabled.nix
    ../../config/sleep-disabled.nix
    ../../config/age-encryption.nix
    ../../config/ssh.nix
    ../../config/ssl.nix
    ../../config/ca-certificates.nix
    ../../config/printserver.nix
    ../../config/git.nix
    ../../users/judiantara
    (import ../../config/disk/efi-luks-btrfs.nix    { name = "${deviceName}"; device = "/dev/disk/by-id/ata-Samsung_SSD_750_EVO_120GB_S2SGNWAGB10646D"; })
    (import ../../config/disk/swap-btrfs-subvol.nix { name = "${deviceName}"; size   = "16G"; })
    (import ./luks-device.nix                       { name = "${deviceName}"; })
    (import ../../config/tpm-boot.nix               { name = "${deviceName}"; })
  ];

  installation.flavor = lib.mkForce "tui";
}
