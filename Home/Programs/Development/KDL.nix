{ pkgs, ... }:

{
  programs.vscode = {
    profiles.default.extensions = with pkgs.vscode-extensions; [
      kdl-org.kdl-v1
    ];

    profiles.default.userSettings = {
      "[kdl]" = {
        "editor.formatOnSave" = true;
      };
    };
  };
}
