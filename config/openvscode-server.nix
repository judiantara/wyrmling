{ user, pkgs, ...}:

{
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      openvscode-server
    ];
  };

  services.openvscode-server = {
    enable                 = true;
    user                   = "${user}";
    group                  = "${user}";
    extraGroups            = [ "wheel" "systemd-journal" "networkmanager" ];
    telemetryLevel         = "off";
    withoutConnectionToken = true;
    host                   = "0.0.0.0";
    port                   = 3000;
  };

  networking.firewall.allowedTCPPorts = [ 3000 ];
}
