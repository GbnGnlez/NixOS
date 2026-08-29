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
          extraHomeArgs ? { },
          extraSystemModules ? [ ],
          extraHomeModules ? [ ],
        }:
        NixPkgs.lib.nixosSystem {
          system = "x86_64-linux";

          specialArgs = {
            inherit
              GPU
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
                    ./Home/Common.nix

                    # Common packages
                    ./Home/Programs/Firefox.nix
                    ./Home/Programs/OnlyOffice.nix

                    # Niri
                    ./Home/Desktop/Niri/Home.nix
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
            ThemeColor = "pink";
            IconVariant = "Light";
            CursorVariant = "Classic";
            AccentColor = "233,58,154";
            LookAndFeel = "";
          };
        };

        IdeaPad = mkHost {
          hostName = "IdeaPad";

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

          extraSystemModules = [
            ./Home/Programs/Spotify.nix
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

          kbdLayout = "us";
          kbdVariant = "colemak";

          extraSystemModules = [
            # NixOS Hardware
            NixOSHardware.nixosModules.lenovo-thinkpad-t14-amd-gen2

            ./Home/Programs/Spotify.nix
            # ./Home/Programs/VirtManager.nix
          ];

          extraHomeArgs = {
            ThemeColor = "blue";
            IconVariant = "Dark";
            CursorVariant = "Ice";
            AccentColor = "61,174,233";
            LookAndFeel = "dark";
          };

          extraHomeModules = [
            ./Home/Programs/Firefox.nix
            ./Home/Programs/PhotoGIMP.nix
            ./Home/Programs/Development/VSCode.nix
          ];
        };

        Desktop = mkHost {
          hostName = "Desktop";

          kbdLayout = "us";
          kbdVariant = "colemak_dh";

          extraSystemModules = [
            ./Home/Programs/Spotify.nix
            ./Home/Programs/VirtManager.nix
          ];

          extraHomeArgs = {
            ThemeColor = "blue";
            IconVariant = "Dark";
            CursorVariant = "Ice";
            AccentColor = "61,174,233";
            LookAndFeel = "dark";
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
