{ lib, modulesPath, ... }:

{
  imports =[
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

#   nixpkgs.hostPlatform = lib.mkForce "x86_64-linux";

  hardware = {
    cpu.intel.updateMicrocode = lib.mkForce true;
  };

  boot.kernelModules = [ "kvm-intel" ];
}
