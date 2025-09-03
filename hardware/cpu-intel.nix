{ lib, modulesPath, ... }:

{
  imports =[
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  hardware = {
    cpu.intel.updateMicrocode = lib.mkForce true;
  };

  boot.kernelModules = [ "kvm-intel" ];

  # Recommended for Intel CPUs to prevent overheating
  services.thermald.enable = lib.mkForce true;
}
