{ ... }:

{
  imports = [
    ../../config/system.nix
    ../../config/system-packages.nix
    ../../config/default-user.nix
    ../../config/age-encryption.nix
    ../../config/ssh.nix
    ../../config/ssl.nix
    ../../config/git.nix
    ../../config/openvscode-server.nix
  ];
}
