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

    hostname = "nixos";

    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    packages = forAllSystems (system: {
      default = let
        stencil = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
           inherit (self) inputs outputs;
            hostname = "${hostname}";
          };
          modules = [
            ../config/systemd-networkd.nix
            ../config/systemd-nspawn-container.nix
            ../config/systemd-nspawn-tarball.nix
            ../config/system.nix
            ../config/git.nix
          ];
        };
      in
        stencil.config.system.build.tarball;
    });
  };
}
