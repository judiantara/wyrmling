{hostname, inputs, outputs, lib, config, pkgs, ...}:
{
  imports = [
    ../../config/system.nix
    ../../config/default-packages.nix
    ../../config/default-user.nix
    ../../config/age-encryption.nix
    ../../config/ssh.nix
    ../../config/ssl.nix
    ../../config/git.nix
    ../../config/openvscode-server.nix
  ];
}
