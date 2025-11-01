{ lib, ... }:

{
  # Enable CUPS to print documents.
  services.printing = {
    enable = lib.mkForce true;
  };

#   hardware.printers = {
#     ensurePrinters = [
#       {
#         name = "Brother_HL_L3240CDW_Series";
#         description = "Brother HL-L3240CDW Series";
#         location = "Opik Office 2nd Floor";
#         deviceUri = "ipp://printer-brother.opik";
#         model = "everywhere";
#         ppdOptions = {
#           PageSize = "A4";
#           cupsIPPSupplies = "true";
#         };
#       }
#       {
#         name = "HP-LaserJet-1020";
#         description = "HP LaserJet 1020";
#         location = "Opik Office 2nd Floor";
#         deviceUri = "ipps://talonwhip.opik:443/printers/HP-LaserJet-1020";
#         model = "everywhere";
#         ppdOptions = {
#           PageSize = "A4";
#         };
#       }
#     ];
#   };

  networking.hosts = {
    "192.168.240.13" = ["printer-brother.opik"];
    "192.168.240.15" = ["talonwhip.opik"];
  };
}
