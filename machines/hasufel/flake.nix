{
  description = "Hasufel NixOS systemd-nspawn Machine configuration";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
      #url = "github:NixOS/nixpkgs/nixos-24.11";
    };

    wyrmling = {
      url = "github:judiantara/wyrmling";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, wyrmling, ... }:
  let
    system ="x86_64-linux";

    user       = "judiantara";
    hostname   = "hasufel";
    machine-id = "61ca31ca9d914412bc9d67e78438415a";
  in {
    nixosConfigurations."${hostname}" = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit (self) inputs outputs;
        hostname   = "${hostname}";
        user       = "${user}";
        machine-id = "${machine-id}";
      };

      modules = wyrmling.nixosModules."${hostname}";
    };
  };
}
