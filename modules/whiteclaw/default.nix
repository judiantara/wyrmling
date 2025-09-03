{ user, ... }:

{
  imports = [
    ../../hardware/rpi4.nix
    ../../config/system.nix
    ../../config/systemd-networkd.nix
    ../../config/console-disabled.nix
    ../../config/disable-sleep.nix
    ../../config/age-encryption.nix
    ../../config/ssh.nix
    ../../config/ssl.nix
    ../../config/ca-certificates.nix
    ../../config/default-user.nix
    ../../config/git.nix
    ../../users/${user}
    ./disk.nix
  ];

#   users.users.${user}.hashedPassword = lib.mkForce "$y$j9T$ubOfrDdZPDNIR4NW/vHmf.$QVRooycc53roZyGJSDW1lbV5fMNcw96EB5.oN/bfJh/";
#   security.u2f.enable = lib.mkForce false;
}
