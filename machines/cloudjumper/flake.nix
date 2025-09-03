{
  description = "CloudJumper NixOS Machine Configuration";

  inputs = {
    nixpkgs = {
      #url = "github:NixOS/nixpkgs/nixos-unstable";
      url = "github:NixOS/nixpkgs/nixos-25.11";
    };

    wyrmling = {
      url = "github:judiantara/wyrmling";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, wyrmling, ... }:
  let
    system = "x86_64-linux";

    user     = "judiantara";
    hostname = "cloudjumper";

  in {
    nixosConfigurations."${hostname}" = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit (self) inputs outputs;
        hostname = "${hostname}";
        user     = "${user}";
      };

      modules = wyrmling.nixosModules."${hostname}";
    };
  };
}
