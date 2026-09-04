{
  nixConfig = {
    extra-substituters = [
      "https://gbngnlez.cachix.org"
    ];

    extra-trusted-public-keys = [
      "gbngnlez.cachix.org-1:4087tPR0DCehBmp1z8gmoRk91VcUOjmcV9KdKI64MOU="
    ];
  };

  inputs = {
    NixPkgs.url = "github:NixOS/NixPkgs/nixos-unstable";

    NixOSHardware = {
      url = "github:NixOS/NixOS-Hardware";
      inputs.nixpkgs.follows = "NixPkgs";
    };

    NUR = {
      url = "github:Nix-Community/NUR";
      inputs.nixpkgs.follows = "NixPkgs";
    };

    HomeManager = {
      url = "github:Nix-Community/Home-Manager";
      inputs.nixpkgs.follows = "NixPkgs";
    };

    # Catppuccin.url = "github:Catppuccin/Nix";

    Stylix = {
      url = "github:Nix-Community/Stylix";
      inputs.nixpkgs.follows = "NixPkgs";
    };

    Spicetify = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "NixPkgs";
    };
  };

  outputs =
    {
      NixPkgs,
      HomeManager,
      NUR,
      NixOSHardware,
      # Catppuccin,
      Stylix,
      Spicetify,
      ...
    }:
    let
      mkHost =
        {
          hostName,
          GPU ? "amdgpu",
          Theme,
          Color,
          extraSystemModules ? [ ],
          extraHomeArgs ? { },
          extraHomeModules ? [ ],
        }:
        NixPkgs.lib.nixosSystem {
          system = "x86_64-linux";

          specialArgs = {
            inherit
              GPU
              Theme
              Color
              Stylix
              Spicetify
              ;
          };

          modules = [
            # NUR
            NUR.modules.nixos.default

            # Stylix
            Stylix.nixosModules.stylix

            # Host
            ./Hosts/${hostName}/Configuration.nix
            ./Hosts/Common.nix

            # System
            # ./System/Desktop/Catppuccin.nix
            ./System/Plymouth.nix
            ./System/PipeWire.nix
            ./Services/Avahi.nix
            ./Services/GarbageCollector.nix

            # Plasma
            # ./System/Desktop/Plasma/Configuration.nix

            # XFCE
            ./System/Desktop/Xfce.nix

            # Niri
            # ./System/Desktop/Niri/Configuration.nix

            # Hostname
            {
              networking.hostName = hostName;
            }
          ]
          ++ extraSystemModules
          ++ [
            # Home Manager
            HomeManager.nixosModules.default

            # Catppuccin
            # Catppuccin.nixosModules.catppuccin

            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;

                backupFileExtension = "backup";
                overwriteBackup = true;

                extraSpecialArgs = {
                  inherit
                    Theme
                    Color
                    Stylix
                    Spicetify
                    ;
                }
                // extraHomeArgs;

                users.nixos = {
                  imports = [
                    ./Home/Common.nix

                    # Catppuccin
                    # ./Home/Desktop/Catppuccin.nix

                    # Spicetify (Home Manager Module)
                    Spicetify.homeManagerModules.default
                    ./Home/Packages/Spicetify.nix

                    # Common packages
                    ./Home/Packages/Firefox.nix
                    ./Home/Packages/OnlyOffice.nix

                    # Xfce
                    ./System/Desktop/Xfce/Home.nix
                    # Plasma
                    # ./System/Desktop/Plasma/Home.nix

                    # Niri
                    # ./Home/Desktop/Niri/Home.nix

                    # Catppuccin
                    # Catppuccin.homeModules.catppuccin
                  ]
                  ++ extraHomeModules;
                };
              };
            }
          ];
        };
    in
    {
      nixosConfigurations = {
        IdeaCentre = mkHost {
          hostName = "IdeaCentre";
          Theme = "Light";
          Color = "pink";
        };

        IdeaPad = mkHost {
          hostName = "IdeaPad";
          Theme = "Dark";
          Color = "pink";
        };

        Pavilion = mkHost {
          hostName = "Pavilion";
          GPU = "i915";
          Theme = "Light";
          Color = "pink";

          extraSystemModules = [
            ./Home/Packages/Spotify.nix
          ];
        };

        ThinkPad = mkHost {
          hostName = "ThinkPad";
          Theme = "Dark";
          Color = "blue";

          extraSystemModules = [
            NixOSHardware.nixosModules.lenovo-thinkpad-t14-amd-gen2
            ./Home/Packages/VirtManager.nix
          ];

          extraHomeModules = [
            ./Home/Packages/PhotoGIMP.nix
            ./Home/Packages/Development/VSCode.nix
          ];
        };
      };
    };
}
