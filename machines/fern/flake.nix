{
  description = "Fern NixOS Machine Configuration";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-26.05";
    };

    wyrmling = {
      url = "github:judiantara/wyrmling";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, wyrmling, ... }:
  let
    system = "x86_64-linux";

    uid      = 1001;
    user     = "anydesk";
    hostname = "fern";

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
