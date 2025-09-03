{ user, ... }:

{
  imports = [
    ../../config/systemd-nspawn-container.nix
    ../../config/systemd-nspawn-container-networking.nix
    ../../config/systemd-resolved.nix
    ../../config/network-extrahosts.nix
    ../../config/system.nix
    ../../config/ca-certificates.nix
    ../../config/git.nix
    ../../config/nix-ld.nix
    ../../config/openvscode-server.nix
    ../../users/${user}
  ];
}
