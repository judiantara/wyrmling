{
  description = "My NixOS Machines Configuration";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # agenix, encrypt decrypt sensitive data
    ragenix = {
      url = "github:yaxitech/ragenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, disko, ragenix, ... }:
  let
    system   = "x86_64-linux";

    systemModules = [
      disko.nixosModules.disko
      ragenix.nixosModules.default
    ];

    cloudjumper  = systemModules ++ [ ./machines/cloudjumper  ];
    doomhorn     = systemModules ++ [ ./machines/doomhorn     ];
    hasufel      = systemModules ++ [ ./machines/hasufel      ];
    hookfang     = systemModules ++ [ ./machines/hookfang     ];
    meatlug      = systemModules ++ [ ./machines/meatlug      ];
    razorback    = systemModules ++ [ ./machines/razorback    ];
    rumbletail   = systemModules ++ [ ./machines/rumbletail   ];
    seiryu       = systemModules ++ [ ./machines/seiryu       ];
    shenlong     = systemModules ++ [ ./machines/shenlong     ];
    skullcrusher = systemModules ++ [ ./machines/skullcrusher ];
    stormfly     = systemModules ++ [ ./machines/stormfly     ];
    toothless    = systemModules ++ [ ./machines/toothless    ];
    whiteclaw    = systemModules ++ [ ./machines/whiteclaw    ];
    windfola     = systemModules ++ [ ./machines/windfola     ];
  in {
    nixosModules = {
      cloudjumper  = cloudjumper;
      doomhorn     = doomhorn;
      hasufel      = hasufel;
      hookfang     = hookfang;
      meatlug      = meatlug;
      razorback    = razorback;
      rumbletail   = rumbletail;
      seiryu       = seiryu;
      shenlong     = shenlong;
      skullcrusher = skullcrusher;
      stormfly     = stormfly;
      toothless    = toothless;
      whiteclaw    = whiteclaw;
      windfola     = windfola;
    };
/*
    nixosMachines = {
      cloudjumper = nixpkgs.lib.nixosSystem {
        system = "${system}";
        modules = cloudjumper;
        specialArgs = {
          hostname = "cloudjumper";
        };
      };

      doomhorn = nixpkgs.lib.nixosSystem {
        system = "${system}";
        modules = doomhorn;
        specialArgs = {
          hostname = "doomhorn";
        };
      };

      hasufel = nixpkgs.lib.nixosSystem {
        system = "${system}";
        modules = hasufel;
        specialArgs = {
          hostname = "hasufel";
        };
      };

      hookfang = nixpkgs.lib.nixosSystem {
        system = "${system}";
        modules = hookfang;
        specialArgs = {
          hostname = "hookfang";
        };
      };

      meatlug = nixpkgs.lib.nixosSystem {
        system = "${system}";
        modules = meatlug;
        specialArgs = {
          hostname = "meatlug";
        };
      };

      razorback = nixpkgs.lib.nixosSystem {
        system = "${system}";
        modules = razorback;
        specialArgs = {
          hostname = "razorback";
        };
      };

      rumbletail = nixpkgs.lib.nixosSystem {
        system = "${system}";
        modules = rumbletail;
        specialArgs = {
          hostname = "rumbletail";
        };
      };

      seiryu = nixpkgs.lib.nixosSystem {
        system = "${system}";
        modules = seiryu;
        specialArgs = {
          hostname = "seiryu";
        };
      };

      shenlong = nixpkgs.lib.nixosSystem {
        system = "${system}";
        modules = shenlong;
        specialArgs = {
          hostname = "shenlong";
        };
      };

      skullcrusher = nixpkgs.lib.nixosSystem {
        system = "${system}";
        modules = skullcrusher;
        specialArgs = {
          hostname = "skullcrusher";
        };
      };

      stormfly = nixpkgs.lib.nixosSystem {
        system = "${system}";
        modules = stormfly;
        specialArgs = {
          hostname = "stormfly";
        };
      };

      toothless = nixpkgs.lib.nixosSystem {
        system = "${system}";
        modules = toothless; 
        specialArgs = {
          hostname = "toothless";
        };
      };

      whiteclaw = nixpkgs.lib.nixosSystem {
        system = "${system}";
        modules = whiteclaw;
        specialArgs = {
          hostname = "whiteclaw";
        };
      };

      windfola = nixpkgs.lib.nixosSystem {
        system = "${system}";
        modules = windfola;
        specialArgs = {
          hostname = "windfola";
        };
      };
    };
*/
  };
}
