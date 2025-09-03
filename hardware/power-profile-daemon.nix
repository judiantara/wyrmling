{ lib, ... }:

{
  services.tlp.enable = lib.mkForce false;
  services.auto-cpufreq.enable = lib.mkForce false;

  services.power-profiles-daemon.enable = lib.mkForce true;
}
