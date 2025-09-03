{ lib, modulesPath, pkgs, ... }:

{
  imports =[
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  hardware = {
    amdgpu.initrd.enable = false;
    cpu.amd.updateMicrocode = lib.mkForce true;
  };

  boot.kernelModules = [ "kvm-amd" ];

  environment.systemPackages = with pkgs; [
    # devices
    cyme
    nvtopPackages.amd
    microcode-amd
    amdctl
  ];
}
