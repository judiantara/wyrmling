{ user, ... }:

{
  imports = [
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
    ../../users/${user}.nix
    ./volume.nix
  ];
}
