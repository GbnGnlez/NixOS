{ pkgs, ... }:

{
  # The set of packages to appear in the user environment.
  home.packages = with pkgs; [
    nixd # Nix language server with option search and evaluation.
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

      # Disable extension server tracing
      "nix.trace.server" = "off";

      # LSP Configuration
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nixd";
      "nix.serverSettings" = {
        "nixd" = {
          "formatting" = {
            "command" = [ "nixfmt" ];
          };
          "options" = {
            "nixos" = {
              "expr" = "(builtins.getFlake \"\${workspaceFolder}\").nixosConfigurations.Desktop.options";
            };
            "home-manager" = {
              "expr" =
                "(builtins.getFlake \"\${workspaceFolder}\").nixosConfigurations.Desktop.options.home-manager.users.type.getSubOptions [ ]";
            };
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
