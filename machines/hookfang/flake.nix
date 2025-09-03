{
  description = "HookFang NixOS Machine Configuration";

  inputs = {
    nixpkgs = {
      #url = "github:NixOS/nixpkgs/nixos-unstable";
      url = "github:NixOS/nixpkgs/nixos-26.05";
    };

    microvm = {
      url = "github:microvm-nix/microvm.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wyrmling = {
      url = "github:judiantara/wyrmling";
      inputs.nixpkgs.follows = "nixpkgs";
    };

#     mms = {
#       url = "github:mkaito/nixos-modded-minecraft-servers";
#       inputs.nixpkgs.follows = "nixpkgs";
#     };

  };

  outputs = { self, nixpkgs, ... }@inputs:
  let
    system = "x86_64-linux";
    hostname = "hookfang";

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
