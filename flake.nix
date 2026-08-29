{
  nixConfig = {
    extra-substituters = [
      "https://gbngnlez.cachix.org"
      "https://spicetify.cachix.org"
    ];

    extra-trusted-public-keys = [
      "gbngnlez.cachix.org-1:4087tPR0DCehBmp1z8gmoRk91VcUOjmcV9KdKI64MOU="
      "spicetify.cachix.org-1:ibKfZ5J5NZm7n4l1as1x87u8m+5oQWb9a4c="
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

    Catppuccin.url = "github:Catppuccin/Nix";

    # Spicetify Nix
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
      Catppuccin,
      Spicetify,
      ...
    }:
    let
      mkHost =
        {
          hostName,
          GPU ? "amdgpu",
          extraSystemModules ? [ ],
          extraHomeArgs ? { },
          extraHomeModules ? [ ],
        }:
        NixPkgs.lib.nixosSystem {
          system = "x86_64-linux";

          specialArgs = {
            inherit GPU Spicetify;
          };

          modules = [
            # NUR
            NUR.modules.nixos.default

            # Spicetify (NixOS Module)
            Spicetify.nixosModules.default

            # Host
            ./Hosts/${hostName}/Configuration.nix
            ./Hosts/Common.nix

            # System
            ./System/Plymouth.nix
            ./System/PipeWire.nix
            ./Services/Avahi.nix
            ./Services/GarbageCollector.nix

            # Niri
            ./System/Desktop/Niri/Configuration.nix

            # Hostname
            {
              networking.hostName = hostName;
            }
          ]
          ++ extraSystemModules
          ++ [
            # Home Manager
            HomeManager.nixosModules.default

            Catppuccin.nixosModules.catppuccin

            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;

                backupFileExtension = "backup";
                overwriteBackup = true;

                extraSpecialArgs = extraHomeArgs {
                  inherit Spicetify;
                };

                users.nixos = {
                  imports = [
                    ./Home/Common.nix

                    # Spicetify (Home Manager Module)
                    Spicetify.homeManagerModules.default

                    # Common packages
                    ./Home/Programs/Firefox.nix
                    ./Home/Programs/OnlyOffice.nix

                    # Niri
                    ./Home/Desktop/Niri/Home.nix

                    Catppuccin.homeModules.catppuccin
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

          extraHomeArgs = {
            Theme = "Light";
            Color = "Pink";
          };
        };

        IdeaPad = mkHost {
          hostName = "IdeaPad";

          extraHomeArgs = {
            Theme = "Dark";
            Color = "Pink";
          };
        };

        Pavilion = mkHost {
          hostName = "Pavilion";

          GPU = "i915";

          extraSystemModules = [
            ./Home/Programs/Spotify.nix
          ];

          extraHomeArgs = {
            Theme = "Light";
            Color = "Pink";
          };
        };

        ThinkPad = mkHost {
          hostName = "ThinkPad";

          extraSystemModules = [
            # NixOS Hardware
            NixOSHardware.nixosModules.lenovo-thinkpad-t14-amd-gen2

            ./Home/Programs/Spotify.nix
            # ./Home/Programs/VirtManager.nix
          ];

          extraHomeArgs = {
            Theme = "Dark";
            Color = "Blue";
          };

          extraHomeModules = [
            ./Home/Programs/Firefox.nix
            ./Home/Programs/PhotoGIMP.nix
            ./Home/Programs/Development/VSCode.nix
          ];
        };

        Desktop = mkHost {
          hostName = "Desktop";

          extraSystemModules = [
            ./Home/Programs/Spotify.nix
            ./Home/Programs/VirtManager.nix
          ];

          extraHomeArgs = {
            Theme = "Dark";
            Color = "Blue";
          };

          extraHomeModules = [
            ./Home/Programs/Firefox.nix
            ./Home/Programs/PhotoGIMP.nix
            ./Home/Programs/Development/VSCode.nix
          ];
        };
      };
    };
}
