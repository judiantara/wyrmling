{ config, pkgs, lib, inputs, ... }:

{
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

  # Opinionated, solely use flake instead of nix channels
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

  # Set your time zone.
  time.timeZone = "Asia/Jakarta";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "id_ID.UTF-8";
    LC_IDENTIFICATION = "id_ID.UTF-8";
    LC_MEASUREMENT = "id_ID.UTF-8";
    LC_MONETARY = "id_ID.UTF-8";
    LC_NAME = "id_ID.UTF-8";
    LC_NUMERIC = "id_ID.UTF-8";
    LC_PAPER = "id_ID.UTF-8";
    LC_TELEPHONE = "id_ID.UTF-8";
    LC_TIME = "id_ID.UTF-8";
  };

  # Enable networking
  networking.networkmanager.enable = true;

  # Open ports in the firewall.
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      22
    ];
  };

  services.resolved = {
    enable = true;
    fallbackDns = [
      "1.1.1.1"
      "8.8.4.4"
    ];
  };

  services.udev.packages = [ pkgs.yubikey-personalization ];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    allowSFTP = false;
    settings = {
      PasswordAuthentication          = false;
      UsePAM                          = false;
      KbdInteractiveAuthentication    = false;
      challengeResponseAuthentication = false;
      X11Forwarding                   = false;
      PermitRootLogin                 = "no";
    };
    extraConfig = ''
      AllowTcpForwarding yes
      AllowAgentForwarding no
      AllowStreamLocalForwarding no
      AuthenticationMethods publickey
    '';
  };

  services.displayManager = {
    defaultSession = "plasma";
    
    sddm = {
      enable = true;
      wayland = {
        enable = true;
      };
    };
  };

  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable sound with pipewire.
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  programs.kdeconnect.enable = true;
  networking.firewall = {
    allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
    allowedUDPPortRanges = [ { from = 1714; to = 1764; } ];
  };

  programs.ssh.startAgent = true;

  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  security.pki.certificates = [
    ''
      OpikCA
      ======
      -----BEGIN CERTIFICATE-----
      MIIEHTCCAwWgAwIBAgIUcZVfJ4pMgAqyKCNcMlotemnOac8wDQYJKoZIhvcNAQEL
      BQAwgZ0xCzAJBgNVBAYTAklEMRMwEQYDVQQIDApKYXdhIFRpbXVyMREwDwYDVQQH
      DAhTdXJhYmF5YTEYMBYGA1UECgwPT3BpayBVYmVyIEFsbGVzMRMwEQYDVQQLDApQ
      cml2YXRlIENBMRgwFgYDVQQDDA9PcGlrIFByaXZhdGUgQ0ExHTAbBgkqhkiG9w0B
      CQEWDm1hc3RlckBjYS5vcGlrMB4XDTIzMTIxOTA3NTI0NloXDTMzMTIxOTA3NTI0
      NlowgZ0xCzAJBgNVBAYTAklEMRMwEQYDVQQIDApKYXdhIFRpbXVyMREwDwYDVQQH
      DAhTdXJhYmF5YTEYMBYGA1UECgwPT3BpayBVYmVyIEFsbGVzMRMwEQYDVQQLDApQ
      cml2YXRlIENBMRgwFgYDVQQDDA9PcGlrIFByaXZhdGUgQ0ExHTAbBgkqhkiG9w0B
      CQEWDm1hc3RlckBjYS5vcGlrMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
      AQEAxSPDNh/U1bLfM/24SXgEHNtLQcMH1ulPOO+ov6psRYQXTP/HQIvKf+RKoRAQ
      O4oYVR9Q7C0c1FVBwPrUBEUD4PPuWdq46c9f3/OaZNMYDzACHGq5kFMFGbN56AcW
      v2AeysQYV0+ov5vGrHKEUquZNgULcrIzdOR3AIB3tzxITZbJ+NKOXfjLIHPG4KWf
      RcC76vpabb9Z9ig/8XLqCDVxlnCget66T2ncUO++YDgXmQFlNqjgioFUINNk5Z2y
      R6UKhhZJzpwwDM5u6/6Xev/WeU3vMr+/Xzg241QY6LYJ2y41OLrCgV/iIwQTME/D
      l5BPdPErWQ4x+7MSi1Kf5y+xCwIDAQABo1MwUTAdBgNVHQ4EFgQU5YlW3GPcFonz
      71f+ch8ZDoYh3YswHwYDVR0jBBgwFoAU5YlW3GPcFonz71f+ch8ZDoYh3YswDwYD
      VR0TAQH/BAUwAwEB/zANBgkqhkiG9w0BAQsFAAOCAQEAgibCfFeji0VJDVinCnmp
      BNJwdPuDEKcE26EzPKn/Zi/Ioa9PrU65wzwNcCkbdmgdu56WG7q4Ueg8MfFL2Yp2
      2m6UTKr7oV7a/vxVp1BrhbXroYBnFSrL1ECtF5lMtYK0EqyCCgyhuzbDgmlqrHTj
      eiE1hGLgvGGS795i5vKQoBN2H1l5nv+5SnMmIIb+3bm6FlQEo0+p0xARYvvSl9PO
      dhVa0guGFyoOAaCCPyP0kjmqSHgtXEin/ukGDGvxBtmZjcxR3yRNug5UxlififEY
      k/Z3IrrdM+5H9DnQMNpsoydDmv80KLo3G3IsjiH1hGYjv8wbaHWJHS7hoE8r2fwB
      EA==
      -----END CERTIFICATE-----
    ''
  ];

  # restore host ssh keys
  environment ={
    etc = {
      "machine-id".source                   = "/nix/persist/etc/machine-id";
      "ssh/ssh_host_rsa_key".source         = "/nix/persist/etc/ssh/ssh_host_rsa_key";
      "ssh/ssh_host_rsa_key.pub".source     = "/nix/persist/etc/ssh/ssh_host_rsa_key.pub";
      "ssh/ssh_host_ed25519_key".source     = "/nix/persist/etc/ssh/ssh_host_ed25519_key";
      "ssh/ssh_host_ed25519_key.pub".source = "/nix/persist/etc/ssh/ssh_host_ed25519_key.pub";
    };
  };

  age = {
    ageBin = "${pkgs.rage}/bin/rage";
    identityPaths = [
      "/nix/persist/etc/ssh/ssh_host_ed25519_key" # prevent warning unable decrypt during install
    ];
  };

  environment.variables = {
    EDITOR="nano";
    HOSTNAME="${config.networking.hostName}";
  };

  environment.systemPackages = with pkgs; [
    nano
    wget
    curl
    home-manager
    pciutils
    usbutils
    cyme
    nvtopPackages.amd
    microcode-amd
    amdctl
    git
    rage
  ];
}
