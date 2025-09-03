{ machine-id, ... }:

{
  # Set machine-id, it will make stable MAC address
  environment.etc = {
    "machine-id" = {
      text = ''
        ${machine-id}
      '';
      mode = "0444";
    };
  };
}
