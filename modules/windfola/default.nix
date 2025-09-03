{ user, ... }:

{
  imports = [
    ../../config/systemd-nspawn-container.nix
    ../../config/systemd-networkd.nix
    ../../config/system.nix
    ../../config/ca-certificates.nix
    ../../config/machine-id.nix
    ../../config/ssh.nix
    ../../config/git.nix
    ../../config/default-user.nix
    ../../config/nix-ld.nix
    ../../users/${user}
  ];
}
