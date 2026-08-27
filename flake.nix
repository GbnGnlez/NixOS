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
  };

  outputs =
    {
      NixPkgs,
      HomeManager,
      NUR,
      NixOSHardware,
      ...
    }:
    let
      mkHost =
        {
          hostName,
          GPU ? "amdgpu",
          sysLocale ? "es_MX.UTF-8",
          kbdLayout ? "latam",
          kbdVariant ? "",
          SwayFX ? false,
          extraHomeArgs ? { },
          extraSystemModules ? [ ],
          extraHomeModules ? [ ],
        }:
        NixPkgs.lib.nixosSystem {
          system = "x86_64-linux";

          specialArgs = {
            inherit
              GPU
              sysLocale
              kbdLayout
              kbdVariant
              SwayFX
              ;
          };

          modules = [
            # NUR
            NUR.modules.nixos.default

            # Host
            ./Hosts/${hostName}/Configuration.nix
            ./Hosts/Common.nix

            # System
            ./System/Plymouth.nix
            ./System/PipeWire.nix
            ./Services/Avahi.nix
            ./Services/GarbageCollector.nix

            # Sway System Module
            ./System/Desktop/Sway/Sway.nix

            # Hostname
            {
              networking.hostName = hostName;
            }
          ]
          ++ extraSystemModules
          ++ [
            # Home Manager
            HomeManager.nixosModules.default

            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;

                backupFileExtension = "backup";
                overwriteBackup = true;

                extraSpecialArgs = extraHomeArgs // {
                  CursorSize = 16;
                  FontSize = 10;
                };

                users.nixos = {
                  imports = [
                    ./Hosts/${hostName}/${hostName}.nix
                    ./Hosts/Common-Home.nix

                    # Common packages
                    ./Packages/Firefox.nix
                    ./Packages/OnlyOffice.nix

                    # Base Sway configuration for ALL hosts
                    ./System/Desktop/Sway/Sway-Home.nix
                  ]
                  # Conditionally import SwayFX module if SwayFX is enabled
                  ++ (if SwayFX then [ ./System/Desktop/Sway/SwayFX.nix ] else [ ])
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
          SwayFX = false;

          extraHomeArgs = {
            ThemeColor = "pink";
            IconVariant = "Light";
            CursorVariant = "Classic";
            AccentColor = "233,58,154";
            LookAndFeel = "";
          };
        };

        IdeaPad = mkHost {
          hostName = "IdeaPad";
          SwayFX = false;

          extraHomeArgs = {
            ThemeColor = "pink";
            IconVariant = "Dark";
            CursorVariant = "Ice";
            AccentColor = "233,58,154";
            LookAndFeel = "dark";
          };
        };

        Pavilion = mkHost {
          hostName = "Pavilion";
          GPU = "i915";
          SwayFX = false;

          extraSystemModules = [
            ./Packages/Spotify.nix
          ];

          extraHomeArgs = {
            ThemeColor = "pink";
            IconVariant = "Light";
            CursorVariant = "Classic";
            AccentColor = "233,58,154";
            LookAndFeel = "";
          };
        };

        ThinkPad = mkHost {
          hostName = "ThinkPad";
          sysLocale = "en_US.UTF-8";
          kbdLayout = "us";
          kbdVariant = "colemak";
          SwayFX = true; # Automatically includes SwayFX.nix

          extraSystemModules = [
            NixOSHardware.nixosModules.lenovo-thinkpad-t14-amd-gen2
            ./Packages/Spotify.nix
          ];

          extraHomeArgs = {
            ThemeColor = "blue";
            IconVariant = "Dark";
            CursorVariant = "Ice";
            AccentColor = "61,174,233";
            LookAndFeel = "dark";
          };

          extraHomeModules = [
            ./Packages/PhotoGIMP.nix
            ./Packages/Development/VSCode.nix
          ];
        };

        Desktop = mkHost {
          hostName = "Desktop";
          sysLocale = "en_US.UTF-8";
          kbdLayout = "us";
          kbdVariant = "colemak_dh";
          SwayFX = true; # Automatically includes SwayFX.nix

          extraSystemModules = [
            ./Packages/Spotify.nix
            ./Packages/VirtManager.nix
          ];

          extraHomeArgs = {
            ThemeColor = "blue";
            IconVariant = "Dark";
            CursorVariant = "Ice";
            AccentColor = "61,174,233";
            LookAndFeel = "dark";
          };

          extraHomeModules = [
            ./Packages/PhotoGIMP.nix
            ./Packages/Development/VSCode.nix
          ];
        };
      };
    };
}
