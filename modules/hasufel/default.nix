{ ... }:

{
  imports = [
    ../../config/systemd-nspawn-container.nix
    ../../config/systemd-networkd.nix
    ../../config/system.nix
    ../../config/default-user.nix
    ../../config/openvscode-server.nix
  ];
}
