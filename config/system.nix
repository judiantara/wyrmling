{hostname, inputs, outputs, lib, config, pkgs, ...}:
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

  networking.hostName = "${hostname}";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable firewall.
  networking.firewall.enable = true;

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

  # Open port for SSH
  networking.firewall.allowedTCPPorts = [ 22 ];

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

    extraConfig.pipewire-pulse."30-network-discover" = {
      "pulse.cmd" = [
        { cmd = "load-module"; args = "module-zeroconf-discover"; }
      ];
    };
  };

  # Enable avahi for mdns service discovery
  services.avahi = {
    enable = true;
    openFirewall = true;
    publish = {
      enable = true;
      addresses = true;
      domain = true;
      userServices = true;
      workstation = true;
    };
  };

  services.pcscd.enable = true;
  # set policy for accessing smart card
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (action.id == "org.debian.pcsc-lite.access_card") {
        return polkit.Result.YES;
      }
    });

    polkit.addRule(function(action, subject) {
      if (action.id == "org.debian.pcsc-lite.access_pcsc") {
        return polkit.Result.YES;
      }
    });
  '';

  programs.kdeconnect.enable = true;

  # Open port for kdeconnect
  networking.firewall = {
    allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
    allowedUDPPortRanges = [ { from = 1714; to = 1764; } ];
  };

  programs.ssh.startAgent = true;

  programs.zsh.enable = true;

  users.defaultUserShell = pkgs.zsh;

  # Add our home network TLS CA
  security.pki.certificates = [
    ''
      OpikCA
      ======
      -----BEGIN CERTIFICATE-----
      MIICATCCAaigAwIBAgIUUgc8uKcAP+E/V4Ar14PYy1yd56owCgYIKoZIzj0EAwIw
      XzELMAkGA1UEBhMCSUQxETAPBgNVBAgTCFN1cmFiYXlhMRIwEAYDVQQHEwlFYXN0
      IEphdmExEjAQBgNVBAoTCU9waWsgSW5jLjEVMBMGA1UEAxMMT3BpayBJbmMuIENB
      MB4XDTI1MDMwOTEwMjUwMFoXDTMwMDMwODEwMjUwMFowXzELMAkGA1UEBhMCSUQx
      ETAPBgNVBAgTCFN1cmFiYXlhMRIwEAYDVQQHEwlFYXN0IEphdmExEjAQBgNVBAoT
      CU9waWsgSW5jLjEVMBMGA1UEAxMMT3BpayBJbmMuIENBMFkwEwYHKoZIzj0CAQYI
      KoZIzj0DAQcDQgAE54hCxJJcIqfjWNnBS16GTemx2w7d43G02NZtGVlNgSkyHoq3
      t7989LreKvW4v+7W1pb4IAIysIrDQcAb+MT9+qNCMEAwDgYDVR0PAQH/BAQDAgEG
      MA8GA1UdEwEB/wQFMAMBAf8wHQYDVR0OBBYEFBp31d4NJFL0aKYln8Wm6s6EBVJF
      MAoGCCqGSM49BAMCA0cAMEQCIFRcE0VRLWD/ZgeE5nEUM+UOCGkSkxP4ugQ4E9w+
      JiERAiAnVnYgmvoAXooraZINBd1Rs8/kx4eXFdk4XsEkV+JoLQ==
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
  };

  environment.systemPackages = with pkgs; [
    nano
    wget
    curl
    home-manager
    inetutils
    dig
    pciutils
    usbutils
    cyme
    nvtopPackages.amd
    microcode-amd
    amdctl
    git
    rage
    yubikey-manager
    yubikey-personalization
    age-plugin-yubikey
    pcsc-tools
    wireguard-tools
  ];

  systemd.services = {
    "getty@".enable = lib.mkForce false;
    "autovt@".enable = lib.mkForce false;
    "serial-getty@".enable = lib.mkForce false;
  };
}
