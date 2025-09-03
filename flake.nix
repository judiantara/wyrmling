{
  description = "My NixOS Machines Configuration";

  inputs = {
    nixpkgs = {
      #url = "github:NixOS/nixpkgs/nixos-unstable";
      url = "github:NixOS/nixpkgs/nixos-25.11";
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
    systemModules = [
      disko.nixosModules.disko
      ragenix.nixosModules.default
    ];

    containerModules = [
      ragenix.nixosModules.default
    ];

    cloudjumper  = systemModules ++ [ ./modules/cloudjumper  ];
    meatlug      = systemModules ++ [ ./modules/meatlug      ];
    skullcrusher = systemModules ++ [ ./modules/skullcrusher ];
    stormfly     = systemModules ++ [ ./modules/stormfly     ];
    toothless    = systemModules ++ [ ./modules/toothless    ];
    windwalker   = systemModules ++ [ ./modules/windwalker   ];

    doomhorn     = containerModules ++ [ ./modules/doomhorn   ];
    hasufel      = containerModules ++ [ ./modules/hasufel    ];
    hookfang     = containerModules ++ [ ./modules/hookfang   ];
    razorback    = containerModules ++ [ ./modules/razorback  ];
    rumbletail   = containerModules ++ [ ./modules/rumbletail ];
    seiryu       = containerModules ++ [ ./modules/seiryu     ];
    shadowfax    = containerModules ++ [ ./modules/shadowfax  ];
    shenlong     = containerModules ++ [ ./modules/shenlong   ];
    windfola     = containerModules ++ [ ./modules/windfola   ];
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
      shadowfax    = shadowfax;
      shenlong     = shenlong;
      skullcrusher = skullcrusher;
      stormfly     = stormfly;
      toothless    = toothless;
      windfola     = windfola;
      windwalker   = windwalker;
    };

    templates = {
      cloudjumper = {
        path = ./machines/cloudjumper;
        description = "CloudJumper NixOS Machine Configuration";
      };
      hasufel = {
        path = ./machines/hasufel;
        description = "Hasufel NixOS Machine Configuration";
      };
      meatlug = {
        path = ./machines/meatlug;
        description = "Meatlug NixOS Machine Configuration";
      };
      shadowfax = {
        path = ./machines/shadowfax;
        description = "Shadowfax NixOS Machine Configuration";
      };
      skullcrusher = {
        path = ./machines/skullcrusher;
        description = "SkullCrusher NixOS Machine Configuration";
      };
      stormfly = {
        path = ./machines/stormfly;
        description = "StormFly NixOS Machine Configuration";
      };
      toothless = {
        path = ./machines/toothless;
        description = "Toothless NixOS Machine Configuration";
      };
      windfola = {
        path = ./machines/windfola;
        description = "Windfola NixOS Machine Configuration";
      };
      windwalker = {
        path = ./machines/windwalker;
        description = "WindWalker NixOS Machine Configuration";
      };
    };
  };
}
