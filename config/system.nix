{ config, pkgs, lib, ... }:

{
  # enable flake feature and the accompanying new nix command
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

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
  programs.ssh.startAgent = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
  };

  users.defaultUserShell = pkgs.zsh;

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
    nix-zsh-completions
  ];
}
