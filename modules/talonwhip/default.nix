{ user, ... }:

{
  imports = [
    ../../hardware/rpi4.nix
    ../../hardware/scanner.nix
    ../../config/bootloader.nix
    ../../config/system.nix
    ../../config/systemd-networkd.nix
    ../../config/systemd-resolved.nix
    ../../config/network-extrahosts.nix
#     ../../config/console-disabled.nix
#     ../../config/sleep-disabled.nix
    ../../config/age-encryption.nix
    ../../config/ssh.nix
    ../../config/ssl.nix
    ../../config/ca-certificates.nix
    ../../config/git.nix
   ../../users/${user}
    ./disk.nix
    ./luks.nix
  ];

#   nixpkgs.config.allowUnfree = true;
}
