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
        "editor.formatOnSave" = true;
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
