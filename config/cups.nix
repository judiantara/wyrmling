{hostname, inputs, outputs, lib, config, pkgs, ...}:
{
  # Enable CUPS to print documents.
  services.printing.enable = true;
}
