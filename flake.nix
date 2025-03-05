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
    
    nixosMachines = {
      cloudjumper = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit (self) inputs outputs; hostname = "cloudjumper";};
        modules = cloudjumper;
      };

      doomhorn = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit (self) inputs outputs; hostname = "doomhorn";};
        modules = doomhorn;
      };

      hasufel = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit (self) inputs outputs; hostname = "hasufel";};
        modules = hasufel;
      };

      hookfang = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit (self) inputs outputs; hostname = "hookfang";};
        modules = hookfang;
      };

      meatlug = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit (self) inputs outputs; hostname = "meatlug";};
        modules = meatlug;
      };

      razorback = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit (self) inputs outputs; hostname = "razorback";};
        modules = razorback;
      };

      rumbletail = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit (self) inputs outputs; hostname = "rumbletail";};
        modules = rumbletail;
      };

      seiryu = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit (self) inputs outputs; hostname = "seiryu";};
        modules = seiryu;
      };

      shenlong = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit (self) inputs outputs; hostname = "shenlong";};
        modules = shenlong;
      };

      skullcrusher = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit (self) inputs outputs; hostname = "skullcrusher";};
        modules = skullcrusher;
      };

      stormfly = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit (self) inputs outputs; hostname = "stormfly";};
        modules = stormfly;
      };

      toothless = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit (self) inputs outputs; hostname = "toothless";};
        modules = toothless; 
      };

      whiteclaw = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit (self) inputs outputs; hostname = "whiteclaw";};
        modules = whiteclaw;
      };

      windfola = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit (self) inputs outputs; hostname = "windfola";};
        modules = windfola;
      };
    };
  };
}
