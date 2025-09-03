{ lib, modulesPath, user, pkgs, ... }:

{
  imports = [
  (modulesPath + "/installer/scan/not-detected.nix")
    ../../config/system.nix
    ../../config/ssh.nix
    ../../config/ca-certificates.nix
    ../../config/networkmanager.nix
    ../../config/systemd-resolved.nix
    ../../config/zram-swap.nix
    ../../config/zsh.nix
    ./disk.nix
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  boot = {
    initrd.availableKernelModules = [
      "xhci_pci"
      "ahci"
      "ohci_pci"
      "ehci_pci"
      "ums_realtek"
      "usb_storage"
      "sd_mod"
    ];
  };

  hardware = {
    amdgpu.initrd.enable = false;
    cpu.amd.updateMicrocode = lib.mkForce true;
  };

  nix.settings.trusted-users = [
    "${user}"
    "judiantara"
  ];

  users.groups.${user} = {
    gid = 1000;
  };

  users.users.${user} = {
    hashedPassword = "*";
    isNormalUser = true;
    home = "/home/${user}";
    createHome = true;
    group = "${user}";
    uid = 1000;
    extraGroups = [
      "networkmanager"
    ];
  };

  users.groups.judiantara = {
    gid = 1001;
  };

  users.users.judiantara = {
    hashedPassword = "*";
    isNormalUser = true;
    home = "/tmp";
    createHome = false;
    group = "judiantara";
    uid = 1001;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  # use memory safe sudo implementation
  security = {
    sudo.enable = lib.mkForce false;
    sudo-rs = {
      enable = lib.mkForce true;
      execWheelOnly = lib.mkForce true;
      extraRules = [
        {
          users = [ "judiantara" ];
          commands = [
            {
              command = "ALL" ;
              options= [ "NOPASSWD" ];
            }
          ];
        }
      ];
    };
    pam = {
      services = {
        login.u2fAuth = true;
        sudo.u2fAuth = true;
      };
      u2f = {
        enable = true;
        settings = {
          interactive = true;
          cue = true;
          origin = "pam://judiantara";
          authfile = pkgs.writeText "u2f-mappings" (lib.concatStrings [
            "judiantara"
            ":6fEVt9/C594Ii7D7S/6JJifTsA0DrRjaZLuoJx2fknY0IvpQ9uOzHphw5dzCRVub/445uXM7+6RpSOJbb9vO5w==,vNeL2KR7vXjeHSOBTMZCuVRCjWM/AmOd9zXsFEHOKYhp6189sMK4klxQylvIIJCs3c8MYA97B2g1++jqcQS6cA==,es256,+presence"
            ":GzDTETgQ+4iNbu+KqGeTHM+7A4DDcfkbANMfCWc+0FvsGhZXV+9HPY/c4PgBKa8nQy4nCeXT0C+sW63vMvqcQw==,6Khxu5rkiDIIWkDB1tLE7bY4YeE+XLzKYVcI3H5TgX2ryrVVFCFW6taxjZ/A/IcawT2zpEV+2WD4iR6YQ2NeeQ==,es256,+presence"
          ]);
        };
      };
    };
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = lib.mkForce true;
    desktopManager.cinnamon.enable = lib.mkForce true;
    displayManager = {
      lightdm = {
        enable = lib.mkForce true;
      };
    };
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable the Cinnamon Desktop Environment.
  services.displayManager = {
    defaultSession = lib.mkForce "cinnamon";
    autoLogin = {
      enable = lib.mkForce true;
      user = "${user}";
    };
  };

  environment.cinnamon.excludePackages = with pkgs; [
    gnome-tour
    gnome-user-docs
    gnome-connections
    gnome-maps
    gnome-music
    gnome-photos
    gnome-weather
    gnome-calculator
    gnome-terminal
    gnome-disk-utility
    gnome-system-monitor
    gnome-screenshot
    gnome-calendar
    gucharmap
    pix
    xed
    xviewer
    xreader
    cinnamon-screensaver
    cinnamon-settings-daemon
    onboard
    celluloid
    xterm
    bulky
    warpinator
    cinnamon-control-center
    file-roller
    blueman
    evolution
  ];

  environment.systemPackages = with pkgs; [
    nemo
    networkmanagerapplet
    anydesk
    papers
    libreoffice-fresh
    ungoogled-chromium
  ];

  programs.evolution.enable = lib.mkForce false;
  programs.ssh.startAgent = lib.mkForce false;
  services.printing.enable = lib.mkForce false;
  services.gnome.gcr-ssh-agent.enable = lib.mkForce false;
  services.upower.enable = lib.mkForce false;
  powerManagement.enable = lib.mkForce false;

  security.rtkit.enable = lib.mkForce true;
  services.pulseaudio.enable = lib.mkForce false;
  services.pipewire.enable = lib.mkForce true;

  services.power-profiles-daemon.enable = lib.mkForce false;
  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
        governor = "performance";
        turbo = "auto";
      };
      charger = {
        governor = "performance";
        turbo = "always";
      };
    };
  };
}
