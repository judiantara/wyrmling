{ ... }:

{
  imports = [
    ../../config/systemd-nspawn-container.nix
    ../../config/systemd-networkd.nix
    ../../config/system.nix
    ../../config/ca-certificates.nix
    ../../config/machine-id.nix
    ../../config/default-user.nix
    ../../config/openvscode-server.nix
  ];
}
