{ config, pkgs, lib, ... }:

{
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 20;

      USB_AUTOSUSPEND = 0;
      RUNTIME_PM_DRIVER_DENYLIST = "mei_me nouveau radeon xhci_hcd ahci";
      AHCI_RUNTIME_PM_ON_AC = "on";
      AHCI_RUNTIME_PM_ON_BAT = "on";

      #Optional helps save long term battery health
      START_CHARGE_THRESH_BAT0 = 40; # 40 and below it starts to charge
      STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging
    };
  };

  # disable power-profile-daemon
  services.power-profiles-daemon.enable = lib.mkForce false;
}
