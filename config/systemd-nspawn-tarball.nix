{ config, pkgs, hostname, user, ... }:

let
  makeTarball = pkgs.callPackage (pkgs.path + "/nixos/lib/make-system-tarball.nix");

#   flakeFile = builtins.toFile "flake.nix" ''
#     {
#       description = "${hostname} NixOS Systemd-nspawn Machine Configuration";
#
#       inputs = {
#         nixpkgs = {
#           url = "github:nixos/nixpkgs/nixos-unstable";
#         };
#
#         wyrmling = {
#           url = "github:judiantara/wyrmling";
#           inputs.nixpkgs.follows = "nixpkgs";
#         };
#       };
#
#       outputs = inputs@{ self, nixpkgs, wyrmling, ...}: {
#         nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
#           system = "${pkgs.system}";
#           specialArgs = {
#             hostname = "${hostname}";
#             user     = "${user}";
#           };
#           modules = wyrmling.nixosModules."${hostname}"
#         };
#       };
#     }
#   '';
in

{
  boot.postBootCommands = ''
    # After booting, register the contents of the Nix store in the Nix
    # database.

    if [ -f /nix-path-registration ]; then
      ${config.nix.package.out}/bin/nix-store --load-db < /nix-path-registration &&
      rm /nix-path-registration
    fi
  '';


  system.build.tarball = makeTarball {
    extraArgs = "--owner=0";

    storeContents = [
      {
        object = config.system.build.toplevel;
        symlink = "/nix/var/nix/profiles/system";
      }
    ];

    contents = [
      {
        # systemd-nspawn requires this file to exist
        source = config.system.build.toplevel + "/etc/os-release";
        target = "/etc/os-release";
      }
#       {
#         source = flakeFile;
#         target = "/etc/nixos/flake.nix";
#       }
    ];

    extraCommands = pkgs.writeScript "extra-commands" ''
      mkdir -p proc sys dev sbin
      ln -sf /nix/var/nix/profiles/system/init sbin/init
    '';
  };
}
