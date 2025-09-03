{
  description = "Windfola NixOS systemd-nspawn Machine configuration";

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
    hostname   = "windfola";
    machine-id = "b3d4f5d41c5c47aeac8b9a0e0e39f898";
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
