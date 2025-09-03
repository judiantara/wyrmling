{ ... }:

{
  imports = [
    ../../config/wsl.nix
    ../../config/system.nix
    ../../config/system-packages.nix
    ../../config/network-extrahosts.nix
    ../../config/default-user.nix
    ../../config/age-encryption.nix
    ../../config/ssh.nix
    ../../config/ssl.nix
    ../../config/git.nix
    ../../config/php.nix
    ../../config/mariadb.nix
    ../../config/openvscode-server.nix
  ];
}
