{hostname, inputs, outputs, lib, config, pkgs, ...}:
{
  imports = [
#     ./disk.nix
    ./volume.nix
    ../../config/system.nix
    ../../config/latest-kernel.nix
    ../../config/default-packages.nix
    ../../config/default-user.nix
    ../../config/age-encryption.nix
    ../../config/ssh.nix
    ../../config/ssl.nix
    ../../config/dns.nix
    ../../config/git.nix
    ../../users/judiantara.nix
  ];
}
