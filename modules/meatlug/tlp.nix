{ ... }:

{
  services.tlp = {
    enable = true;
    settings = {
      # Lenovo battery conservation mode
      IDEA_BAT_CONSMODE="1";
    };
  };
}
