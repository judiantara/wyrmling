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
    whiteclaw    = systemModules ++ [ ./modules/whiteclaw    ];

    doomhorn     = containerModules ++ [ ./modules/doomhorn   ];
    hasufel      = containerModules ++ [ ./modules/hasufel    ];
    hookfang     = containerModules ++ [ ./modules/hookfang   ];
    razorback    = containerModules ++ [ ./modules/razorback  ];
    rumbletail   = containerModules ++ [ ./modules/rumbletail ];
    seiryu       = containerModules ++ [ ./modules/seiryu     ];
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
      shenlong     = shenlong;
      skullcrusher = skullcrusher;
      stormfly     = stormfly;
      toothless    = toothless;
      whiteclaw    = whiteclaw;
      windfola     = windfola;
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
      whiteclaw = {
        path = ./machines/whiteclaw;
        description = "WhiteClaw NixOS Machine Configuration";
      };
    };
  };
}
