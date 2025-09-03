{
  description = "TalonWhip NixOS Machine Configuration";

  inputs = {
    nixpkgs = {
      #url = "github:NixOS/nixpkgs/nixos-unstable";
      url = "github:NixOS/nixpkgs/nixos-26.05";
    };

    wyrmling = {
      url = "github:judiantara/wyrmling";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, wyrmling, ... }:
  let
    system = "aarch64-linux";

    uid      = 1000;
    user     = "judiantara";
    hostname = "talonwhip";

  in {
    nixosConfigurations."${hostname}" = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit (self) inputs outputs;
        hostname = "${hostname}";
        user     = "${user}";
        uid      = uid;
      };

      modules = wyrmling.nixosModules."${hostname}";
    };
  };
}
