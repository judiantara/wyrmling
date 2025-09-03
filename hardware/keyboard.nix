{ pkgs, ... }:

{
  # tell libinput to disables trackpad when typing
  environment.etc."libinput/local-overrides.quirks".text = ''
    [Serial Keyboards]

    MatchUdevType=keyboard
    MatchName=keyd*keyboard
    AttrKeyboardIntegration=internal
  '';

  environment.systemPackages = [ pkgs.keyd ];
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
            # Change Print Screen to Insert
            sysrq = "insert";
            print = "insert";

            # Maps capslock to ctrl when pressed and symbol when held.
            capslock = "layer(symbol)";
          };
          symbol = {
            f = "~";
            g = "`";
            p = "print";
            a = "C-a";
            d = "C-S-v";
            c = "C-insert";
            v = "S-insert";
            x = "C-x";
            z = "C-Z";
            s = "C-S-z";
#             # for tmux split pane
#             w = ''macro(C-b ;)'';
#             s = ''macro(C-b ")'';
#             a = ''macro(C-b $)'';
#             d = ''macro(C-b %)'';
#
#             # for tmux movement
#             i = ''macro(C-b up)'';
#             k = ''macro(C-b down)'';
#             j = ''macro(C-b left)'';
#             l = ''macro(C-b right)'';
          };
        };
        extraConfig = ''
          # put here any extra-config, e.g. you can copy/paste here directly a configuration, just remove the ids part
        '';
      };
    };
  };
}
