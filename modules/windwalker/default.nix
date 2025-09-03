{ lib, ... }:

{
  imports = let
    deviceName = "Windwalker";
  in [
    ../../hardware/rpi4.nix
    ../../config/bootloader.nix
    ../../config/zram-swap.nix
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
    ../../config/git.nix
    ../../config/nix-cache-proxy.nix
   ../../users/judiantara
   (import ../../config/disk/efi-ext4.nix { name = "${deviceName}"; device = "/dev/disk/by-id/ata-TEAML5Lite3D240G_AB20180625A0102860"; })
   (import ../../luks-device.nix          { name = "${deviceName}"; })
  ];

  installation.flavor = lib.mkForce "tui";}
