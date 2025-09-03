{ ... }:

{
  imports = let
    deviceName = "Seiryu";
  in [
    ../../config/system.nix
    ../../config/bootloader.nix
    ../../config/system-packages.nix
    ../../config/avahi-mdns.nix
    ../../config/network-extrahosts.nix
    ../../config/default-user.nix
    ../../config/age-encryption.nix
    ../../config/ssh.nix
    ../../config/ssl.nix
    ../../config/git.nix
    ../../users/judiantara
    (import ../../config/disk/efi-luks-btrfs.nix    { name = "${deviceName}"; device = "/dev/sdx"; })
    (import ../../config/disk/swap-btrfs-subvol.nix { name = "${deviceName}"; size   = "8G"; })
    (import ../../config/luks-device.nix            { name = "${deviceName}"; })
    (import ../../config/tpm-boot.nix               { name = "${deviceName}"; })
  ];

  boot.initrd.availableKernelModules = [ "ata_piix" "ahci" "sd_mod" "sr_mod" ];
}
