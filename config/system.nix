{lib, config, pkgs, inputs, hostname, ...}:
{
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

  # Opinionated: solely use flake instead of nix channels
  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";

      # Opinionated: disable global registry
      flake-registry = "";

      # Workaround for https://github.com/NixOS/nix/issues/9574
      nix-path = config.nix.nixPath;
    };
    # Opinionated: disable channels
    channel.enable = false;

    # Opinionated: make flake registry and nix path match flake inputs
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  networking.hostName = "${hostname}";

  # Set your time zone.
  time.timeZone = "Asia/Jakarta";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_IDENTIFICATION = "id_ID.UTF-8";
      LC_MEASUREMENT    = "id_ID.UTF-8";
      LC_ADDRESS        = "id_ID.UTF-8";
      LC_MONETARY       = "id_ID.UTF-8";
      LC_NAME           = "id_ID.UTF-8";
      LC_NUMERIC        = "id_ID.UTF-8";
      LC_PAPER          = "id_ID.UTF-8";
      LC_TELEPHONE      = "id_ID.UTF-8";
      LC_TIME           = "id_ID.UTF-8";
    };
  };
  
  programs.zsh.enable = true;

  users.defaultUserShell = pkgs.zsh;

  environment.variables = {
    EDITOR="nano";
  };

  systemd.services = {
    "getty@".enable = lib.mkForce false;
    "autovt@".enable = lib.mkForce false;
    "serial-getty@".enable = lib.mkForce false;
  };

  # use memory safe sudo implementation
  security.sudo.enable = lib.mkForce false;
  security.sudo-rs = {
    enable = true;
    execWheelOnly = false;
  };
}
