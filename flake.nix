{
  description = "My NixOS Machines Configuration";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
      #url = "github:NixOS/nixpkgs/nixos-24.11";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # agenix, encrypt decrypt sensitive data
    ragenix = {
      url = "github:yaxitech/ragenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, disko, ragenix, ... }@inputs:
    let
      inherit (self) outputs;
      
      systems = [
        "x86_64-linux"
      ];
      
      systemModules = [
        disko.nixosModules.disko
        ragenix.nixosModules.default
      ];

      # This is a function that generates an attribute by calling a function you
      # pass to it, with each system as an argument
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in {
    nixosConfigurations = {
      cloudjumper = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs; hostname = "cloudjumper";};
        modules = systemModules ++ [
          ./machines/cloudjumper
        ];
      };

      meatlug = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs; hostname = "meatlug";};
        modules = systemModules ++ [
          ./machines/meatlug
        ];
      };

      skullcrusher = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs; hostname = "skullcrusher";};
        modules = systemModules ++ [
          ./machines/skullcrusher
        ];
      };

      stormfly = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs; hostname = "stormfly";};
        modules = systemModules ++ [
          ./machines/stormfly
        ];
      };

      toothless = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs; hostname = "toothless";};
        modules = systemModules ++ [
          ./machines/toothless
        ];
      };
    };
  };
}
