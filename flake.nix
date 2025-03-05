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

    # home-manager, used for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager";
      #url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, disko, home-manager, ... }@inputs: {
    nixosConfigurations = {
      hookfang = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./machines/hookfang/configuration.nix
        ];
      };

      skullcrusher = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          disko.nixosModules.disko
          ./config/system.nix
          ./config/latest-kernel.nix
          ./hardware/amd.nix
          ./hardware/keyboard.nix
          ./machines/skullcrusher/disk.nix
          ./machines/skullcrusher/luks.nix
          ./machines/skullcrusher/hostname.nix
          ./users/judiantara.nix
        ];
      };

     stormfly = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          disko.nixosModules.disko
          ./config/system.nix
          ./config/latest-kernel.nix
          ./hardware/amd.nix
          ./hardware/keyboard.nix
          ./machines/stormfly/disk.nix
          ./machines/stormfly/luks.nix
          ./machines/stormfly/hostname.nix
          ./users/judiantara.nix
        ];
      };

      toothless = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          disko.nixosModules.disko
          ./config/system.nix
          ./config/latest-kernel.nix
          ./hardware/amd.nix
          ./hardware/keyboard.nix
          ./machines/toothless/disk.nix
          ./machines/toothless/luks.nix
          ./machines/toothless/hostname.nix
          ./users/judiantara.nix
        ];
      };

      meatlug = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          disko.nixosModules.disko
          ./config/system.nix
          ./config/latest-kernel.nix
          ./hardware/amd.nix
          ./hardware/keyboard.nix
          ./hardware/bluetooth.nix
          ./machines/meatlug/disk.nix
          ./machines/meatlug/luks.nix
          ./machines/meatlug/hostname.nix
          ./users/u2f-pam.nix
          ./users/judiantara.nix
        ];
      };

     cloudjumper = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          disko.nixosModules.disko
          ./config/system.nix
          ./config/latest-kernel.nix
          ./hardware/amd.nix
          ./hardware/keyboard.nix
          ./machines/cloudjumper/disk.nix
          ./machines/cloudjumper/luks.nix
          ./machines/cloudjumper/hostname.nix
          ./users/judiantara.nix
        ];
      };
    };

    home-manager.useUserPackages = true;
    home-manager.useGlobalPkgs = true;
    home-manager.extraSpecialArgs = {
      inherit inputs;
      inherit (self.config.networking) hostName;
    };
  };
}
