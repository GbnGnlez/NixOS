# https://wiki.nixos.org/wiki/Visual_Studio_Code
# https://github.com/nix-community/vscode-nix-ide

{ pkgs, ... }:

{
  # The set of packages to appear in the user environment.
  home.packages = with pkgs; [
    nil # Yet another language server for Nix.
    nixfmt # Official formatter for Nix code.
  ];

  # Declarative Git configuration
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "GbnGnlez";
        email = "GibranN.GonzalezS@outlook.com";
      };

      init = {
        defaultBranch = "main";
      };

      pull = {
        rebase = true;
      };
    };
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;

    profiles.default.extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
      github.vscode-github-actions
      redhat.vscode-yaml
    ];

    profiles.default.userSettings = {
      "[nix]" = {
        "editor.defaultFormatter" = "jnoortheen.nix-ide";
        "editor.formatOnSave" = true;
      };

      "[yaml]" = {
        "editor.defaultFormatter" = "redhat.vscode-yaml";
        "editor.formatOnSave" = true;
      };

      "git.enableSmartCommit" = true;

      # LSP Configuration for Nil
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nil";
      "nix.serverSettings" = {
        "nil" = {
          "formatting" = {
            "command" = [ "nixfmt" ];
          };
        };
      };

      "yaml.disableSchemaDetection" = [
        "**/.github/workflows/*.yml"
        "**/.github/workflows/*.yaml"
        "**/.gitea/workflows/*.yml"
        "**/.gitea/workflows/*.yaml"
        "**/.forgejo/workflows/*.yml"
        "**/.forgejo/workflows/*.yaml"
      ];
    };
  };

  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      "text/plain" = [ "code.desktop" ];
      "text/x-nix" = [ "code.desktop" ];
      "text/csv" = [ "code.desktop" ];
      "text/yaml" = [ "code.desktop" ];
      "application/x-yaml" = [ "code.desktop" ];
    };
  };
}
