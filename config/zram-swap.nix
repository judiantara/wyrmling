{ ... }:

{
  zramSwap = {
    enable = true;
    priority = 100;
    algorithm = "lz4";
    swapDevices = 1;
    memoryPercent = 50;
  };
}
