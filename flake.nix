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
      system = "x86_64-linux";
      systemModules = [
        disko.nixosModules.disko
        ragenix.nixosModules.default
        ./config/system.nix
        ./config/latest-kernel.nix
        ./config/tls-certificate.nix
        ./hardware/amd.nix
        ./hardware/keyboard.nix
        ./users/u2f-pam.nix
        ./users/judiantara.nix
      ];
    in {
    nixosConfigurations = {
      cloudjumper = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = systemModules ++ [
          ./machines/cloudjumper/disk.nix
          ./machines/cloudjumper/luks.nix
          ./machines/cloudjumper/hostname.nix
        ];
      };

      meatlug = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = systemModules ++ [
          ./hardware/bluetooth.nix
          ./machines/meatlug/disk.nix
          ./machines/meatlug/luks.nix
          ./machines/meatlug/hostname.nix
        ];
      };

      skullcrusher = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = systemModules ++ [
          ./machines/skullcrusher/disk.nix
          ./machines/skullcrusher/luks.nix
          ./machines/skullcrusher/hostname.nix
        ];
      };

      stormfly = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = systemModules ++ [
          ./machines/stormfly/disk.nix
          ./machines/stormfly/luks.nix
          ./machines/stormfly/hostname.nix
        ];
      };

      toothless = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = systemModules ++ [
          ./machines/toothless/disk.nix
          ./machines/toothless/luks.nix
          ./machines/toothless/hostname.nix
        ];
      };
    };
  };
}
