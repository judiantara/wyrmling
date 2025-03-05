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
    home-user    = [ ./users/generic..nix ];
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
      home-user    = home-user;
    };
  };
}
