{
  description = "Hasufel NixOS systemd-nspawn Machine configuration";

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
    system ="x86_64-linux";

    user       = "judiantara";
    hostname   = "hasufel";
    MACAddress = "d6:41:e8:01:43:4d";
  in {
    nixosConfigurations."${hostname}" = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit (self) inputs outputs;
        hostname   = "${hostname}";
        user       = "${user}";
        MACAddress = "${MACAddress}";
      };

      modules = wyrmling.nixosModules."${hostname}";
    };
  };
}
