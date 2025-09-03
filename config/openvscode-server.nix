{ user, pkgs, ...}:

{
  programs.nix-ld.enable = true;

  programs.nix-ld.libraries = with pkgs; [
    openvscode-server
  ];

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

#   environment.systemPackages = with pkgs; [
#     socat
#   ];
#
#   systemd.services.openvscode-server-https = {
#     enable = true;
#     description = "Openvscode-server TLS Termination service";
#     serviceConfig = {
#       Type="simple";
#       StandardOutput="journal";
#       StandardError="journal";
#       ExecStart = "${pkgs.socat}/bin/socat -lm -d openssl-listen:9443,reuseaddr,fork,certificate=/etc/ssl/certs/host-cert.pem,key=/etc/ssl/certs/host-key.pem,verify=0 tcp-connect:localhost:3000";
#       RestartForceExitStatus="143";
#       SuccessExitStatus="143";
#     };
#     wantedBy = [ "multi-user.target" ];
#   };
}
