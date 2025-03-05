{ config, pkgs, lib, ... }:

{
  services.keyd = {
    enable = true;
    keyboards = {
      # The name is just the name of the configuration file, it does not really matter
      default = {
        ids = [ "*" ]; # what goes into the [id] section, here we select all keyboards
        # Everything but the ID section:
        settings = {
          # The main layer, if you choose to declare it in Nix
          main = {
            # Maps capslock to ctrl when pressed and symbol when held.
            capslock = "layer(symbol)";
          };
          symbol = {
            d = "~";
            f = "`";
          };
          meta = {
            w = ''macro(C-b ;)'';
            s = ''macro(C-b ")'';
            a = ''macro(C-b $)'';
            d = ''macro(C-b %)'';
            i = ''macro(C-b up)'';
            k = ''macro(C-b down)'';
            j = ''macro(C-b left)'';
            l = ''macro(C-b right)'';
          };
        };
        extraConfig = ''
          # put here any extra-config, e.g. you can copy/paste here directly a configuration, just remove the ids part
        '';
      };
    };
  };
}
