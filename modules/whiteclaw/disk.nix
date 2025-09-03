{ ... }:

{
  fileSystems."/" = {
    device = "/dev/disk/by-partlabel/WhiteClaw";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-partlabel/WhiteClawESP";
    fsType = "vfat";
    options = [ "fmask=0022" "dmask=0022" ];
  };

  swapDevices = [
    { device = "/dev/disk/by-partlabel/WhiteClawSwap"; }
  ];
}
