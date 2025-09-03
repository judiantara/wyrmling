{ lib, modulesPath, ... }:

{
  imports =[
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  hardware = {
    amdgpu.initrd.enable = false;
    cpu.amd.updateMicrocode = lib.mkForce true;
  };

  boot.kernelModules = [ "kvm-amd" ];
}
