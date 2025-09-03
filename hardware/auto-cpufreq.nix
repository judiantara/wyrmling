{ lib, ... }:

{
  services.tlp.enable = lib.mkForce false;
  services.power-profiles-daemon.enable = lib.mkForce false;

  services.auto-cpufreq = {
    enable = lib.mkForce true;
    settings = {
      battery = {
        governor = "performance";
        turbo = "auto";
      };
      charger = {
        governor = "performance";
        turbo = "always";
      };
    };
  };
}
