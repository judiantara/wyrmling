{ user, ...}:

{
  imports = [
    ../../config/system.nix
    ../../config/latest-kernel.nix
    ../../config/system-packages.nix
    ../../config/default-user.nix
    ../../config/age-encryption.nix
    ../../config/ssh.nix
    ../../config/ssl.nix
    ../../config/dns.nix
    ../../config/git.nix
    ../../users/${user}.nix
    ./volume.nix
  ];
}
