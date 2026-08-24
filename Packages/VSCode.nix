# https://wiki.nixos.org/wiki/Visual_Studio_Code
# https://github.com/nix-community/vscode-nix-ide

{ pkgs, ... }:

{
  # The set of packages to appear in the user environment.
  home.packages = with pkgs; [
    nil # Yet another language server for Nix.
    nixfmt # Official formatter for Nix code.
  ];

  programs.git = {
    enable = true;
    userName = "GbnGnlez";
    userEmail = "GibranN.GonzalezS@outlook.com";
  };

  programs.vscode = {
    enable = true; # Whether to enable VSCode editor.
    package = pkgs.vscode.fhs; # The vscode package to use.

    # The extensions Visual Studio Code should be started with.
    profiles.default.extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide # Nix language support with formatting and error report.
      github.vscode-github-actions # Visual Studio Code extension for GitHub Actions workflows and runs.
      redhat.vscode-yaml # YAML Language Support by Red Hat.
    ];

    # Configuration written to Visual Studio Code's settings.json.
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
    enable = true; # Whether to manage $XDG_CONFIG_HOME/mimeapps.list.

    defaultApplications = {
      "text/plain" = [ "code.desktop" ]; # .txt
      "text/x-nix" = [ "code.desktop" ]; # .nix
      "text/csv" = [ "code.desktop" ]; # .csv
      "text/yaml" = [ "code.desktop" ]; # .yaml
      "application/x-yaml" = [ "code.desktop" ]; # .yml
    };
  };
}
