{inputs, outputs, lib, config, pkgs, ...}:
{
  programs.kdeconnect.enable = true;

  # Open port for kdeconnect
  networking.firewall = {
    allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
    allowedUDPPortRanges = [ { from = 1714; to = 1764; } ];
  };
}
