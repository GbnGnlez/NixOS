# https://github.com/marketplace/actions/install-nix

{ pkgs, ... }:

{
  programs.vscode = {
    profiles.default.extensions = with pkgs.vscode-extensions; [
      github.vscode-github-actions
      redhat.vscode-yaml
    ];

    profiles.default.userSettings = {
      "[yaml]" = {
        "editor.defaultFormatter" = "redhat.vscode-yaml";
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
}
