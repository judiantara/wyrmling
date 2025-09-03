{ lib, ... }:

{
  imports = let
    deviceName = "Windwalker";
  in [
    ../../hardware/rpi4.nix
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
    ../../config/git.nix
    ../../config/nginx-reverse-proxy.nix
    ../../config/nix-cache-proxy.nix
   ../../users/judiantara
    (import ../../config/disk-partition.nix { name = "${deviceName}"; device =  "/dev/sda"; })
    (import ../../config/disk-swap.nix      { name = "${deviceName}"; size   =  "16G"; })
    (import ../../luks-device.nix           { name = "${deviceName}"; })
  ];

  installation.flavor = lib.mkForce "tui";}
