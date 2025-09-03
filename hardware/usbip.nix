{ pkgs, lib, config, ... }:

{
  config.environment.systemPackages = with pkgs; lib.mkIf (config.services.usbip.enable) [
    gawk
    linuxPackages.usbip
  ];

  config.boot.kernelModules = lib.mkIf (config.services.usbip.enable) [
    "usbip-core"
    "vhci-hcd"
  ];

  config.programs.zsh = lib.mkIf (config.programs.zsh.enable) {
    shellAliases = {
      usbip         = "/run/wrappers/bin/sudo ${pkgs.linuxPackages.usbip}/bin/usbip --debug";
      usbip-ls      = "/run/wrappers/bin/sudo ${pkgs.linuxPackages.usbip}/bin/usbip list -r talonwhip.opik";
      usbip-port    = "/run/wrappers/bin/sudo ${pkgs.linuxPackages.usbip}/bin/usbip port";
      webcam1-on    = "_add-usbip 1-1.2.4.2";
      webcam1-off   = "_rem-usbip 1-1.2.4.2";
      webcam2-on    = "_add-usbip 1-1.2.4.3";
      webcam2-off   = "_rem-usbip 1-1.2.4.3";
      webcam3-on    = "_add-usbip 1-1.2.4.4";
      webcam3-off   = "_rem-usbip 1-1.2.4.4";
      webcam-on     = "webcam2-on";
      webcam-off    = "webcam2-off";
    };

    shellInit = ''
function _add-usbip() {
  /run/wrappers/bin/sudo ${pkgs.linuxPackages.usbip}/bin/usbip attach -r talonwhip.local -b $1
}

function _rem-usbip() {
  /run/wrappers/bin/sudo ${pkgs.linuxPackages.usbip}/bin/usbip detach -p $(( $(/run/wrappers/bin/sudo ${pkgs.linuxPackages.usbip}/bin/usbip port | ${pkgs.gawk}/bin/awk -v pat=$1 -F"-" '$0~pat { print $2 }')-1 ))
}

    '';
  };
}
