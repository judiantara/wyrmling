{
  description = "Golden image for NixOS systemd-nspawn container";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
  };

  outputs = { self, nixpkgs, ... }:
  let
    systems = [
      "aarch64-linux"
      "x86_64-linux"
    ];

    user     = "nix";
    hostname = "stencil";

    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    packages = forAllSystems (system: {
      default = let
        stencil = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
           inherit (self) inputs outputs;
            hostname = "${hostname}";
            user     = "${user}";
          };
          modules = [
            ../../config/systemd-nspawn-container.nix
            ../../config/systemd-nspawn-tarball.nix
            ../../config/systemd-networkd.nix
            ../../config/system.nix
            ../../config/default-user.nix
          ];
        };
      in
        stencil.config.system.build.tarball;
    });
  };
}
