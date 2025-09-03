{ pkgs, lib, ... }:

{
  # Enable CUPS to print documents.
  services.printing = {
    enable = lib.mkForce true;
  };

  hardware.printers = {
    ensurePrinters = [
      {
        name = "Brother_HL_L3240CDW_Series";
        description = "Brother HL-L3240CDW Series";
        location = "Opik Office 2nd Floor";
        deviceUri = "ipp://printer-brother.opik";
        model = "everywhere";
        ppdOptions = {
          PageSize = "A4";
          cupsIPPSupplies = "true";
        };
      }
      {
        name = "HP-LaserJet-1020";
        description = "HP LaserJet 1020";
        location = "Opik Office 2nd Floor";
        deviceUri = "ipps://talonwhip.opik:443/printers/HP-LaserJet-1020";
        model = "everywhere";
        ppdOptions = {
          PageSize = "A4";
        };
      }
    ];
  };

  systemd.services."ensure-printers" = {
    requires = lib.mkForce ["network-online.target"];
    after    = lib.mkForce ["network-online.target" "cups.service"];
    preStart = ''
      set -euo pipefail

      ${pkgs.networkmanager}/bin/nm-online -s -q
      while ! ${pkgs.iputils}/bin/ping -4 -c 1 talonwhip.opik &>/dev/null; do sleep 1; done
    '';
  };
}
