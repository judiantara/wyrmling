{ user, ... }:

{
  imports = [
    ../../hardware/rpi4.nix
    ../../config/bootloader.nix
    ../../config/system.nix
    ../../config/systemd-networkd.nix
    ../../config/systemd-resolved.nix
    ../../config/network-extrahosts.nix
    ../../config/console-disabled.nix
    ../../config/sleep-disabled.nix
    ../../config/age-encryption.nix
    ../../config/ssh.nix
    ../../config/ssl.nix
    ../../config/ca-certificates.nix
    ../../config/git.nix
    ../../config/nginx-reverse-proxy.nix
    ../../config/nix-cache-proxy.nix
   ../../users/${user}
    ./disk.nix
  ];

#   services.ncps = lib.mkForce {
#     upstream = {
#       caches = [
#         "https://cache.toothless.opik"
#         "https://nix-community.cachix.org"
#         "https://cache.nixos.org"
#       ];
#       publicKeys = [
#         "cache.toothless.opik:0JDArfRwnyDYaX4f/voVvFEs4e24Jl9cZPrV/az6r3g="
#         "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
#         "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
#       ];
#     };
#   };

#   users.users.${user}.hashedPassword = lib.mkForce "$y$j9T$ubOfrDdZPDNIR4NW/vHmf.$QVRooycc53roZyGJSDW1lbV5fMNcw96EB5.oN/bfJh/";
#   security.u2f.enable = lib.mkForce false;
}
