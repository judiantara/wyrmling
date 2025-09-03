{ lib, config, ... }:

{
  console = lib.mkIf (config.console.enable) {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # use gpu accelerated and unicode capable terminal
  services.kmscon = lib.mkIf (config.console.enable) {
    enable       = true;
    useXkbConfig = true;
    hwRender     = true;
    extraConfig  = "font-size=14";
    extraOptions = "--term xterm-256color";
  };

  systemd.services = lib.mkIf (! config.console.enable) {
    "getty@".enable = lib.mkForce false;
    "autovt@".enable = lib.mkForce false;
    "serial-getty@".enable = lib.mkForce false;
  };
}
