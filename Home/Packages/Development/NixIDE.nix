# https://github.com/nix-community/vscode-nix-ide

{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nixd
    nixfmt # o pkgs.nixfmt
  ];

  programs.vscode = {
    profiles.default.extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
    ];

    profiles.default.userSettings = {
      "[nix]" = {
        "editor.defaultFormatter" = "jnoortheen.nix-ide";
      };

      "editor.formatOnSave" = true;
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nixd";
      "nix.serverSettings" = {
        "nixd" = {
          "formatting" = {
            "command" = [ "nixfmt" ];
          };
          "options" = {
            "nixos" = {
              "expr" = "(builtins.getFlake \"/home/nixos/NixOS\").nixosConfigurations.ThinkPad.options";
            };
            "home-manager" = {
              "expr" =
                "(builtins.getFlake \"/home/nixos/NixOS\").nixosConfigurations.ThinkPad.options.home-manager.users.type.getSubOptions [ ]";
            };
          };
        };
      };
    };
  };
}
