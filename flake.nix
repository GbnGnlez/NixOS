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

    PlasmaManager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "NixPkgs";
      inputs.home-manager.follows = "HomeManager";
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
      PlasmaManager,
      ...
    }:
    let
      mkHost =
        {
          hostName,
          GPU ? "amdgpu",
          DarkTheme ? false,
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
              DarkTheme
              Color
              Stylix
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
            ./System/Desktop/Plasma/Configuration.nix

            # XFCE
            # ./System/Desktop/Xfce.nix

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
                    DarkTheme
                    Color
                    Stylix
                    ;
                }
                // extraHomeArgs;

                users.nixos = {
                  imports = [
                    ./Home/Common.nix

                    # Catppuccin
                    # ./Home/Desktop/Catppuccin.nix

                    # Common packages
                    ./Home/Packages/Firefox.nix
                    ./Home/Packages/OnlyOffice.nix

                    # Xfce
                    # ./System/Desktop/Xfce/Home.nix

                    # Plasma Manager
                    PlasmaManager.homeModules.plasma-manager

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
          Color = "pink";
        };

        IdeaPad = mkHost {
          hostName = "IdeaPad";
          DarkTheme = true;
          Color = "pink";
        };

        Pavilion = mkHost {
          hostName = "Pavilion";
          GPU = "i915";
          Color = "pink";

          extraHomeArgs = {
            inherit Spicetify;
          };

          extraHomeModules = [
            Spicetify.homeManagerModules.default
            ./Home/Packages/Spicetify.nix
          ];
        };

        ThinkPad = mkHost {
          hostName = "ThinkPad";
          DarkTheme = true;
          Color = "blue";

          extraSystemModules = [
            NixOSHardware.nixosModules.lenovo-thinkpad-t14-amd-gen2
            ./Home/Packages/VirtManager.nix
          ];

          extraHomeArgs = {
            inherit Spicetify;
          };

          extraHomeModules = [
            Spicetify.homeManagerModules.default
            ./Home/Packages/Spicetify.nix
            ./Home/Packages/PhotoGIMP.nix
            ./Home/Packages/Development/VSCode.nix
          ];
        };
      };
    };
}
