{
  description = "StormFly NixOS Machine Configuration";

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

  outputs = { self, nixpkgs, ... }@inputs:
  let
    system = "x86_64-linux";
    hostname = "stormfly";

    # Create shorthand aliases for inputs
    inherit (inputs) wyrmling;

  in {
    nixosConfigurations."${hostname}" = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit self inputs;
        hostname = "${hostname}";
      };

      modules = wyrmling.nixosModules."${hostname}";
    };
  };
}
