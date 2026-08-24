# https://wiki.nixos.org/wiki/Visual_Studio_Code

{ pkgs, ... }:

{
  imports = [
    ./Git.nix
    ./NixIDE.nix
    ./GitHubActions.nix
  ];

  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;

    profiles.default.userSettings = {
      "git.enableSmartCommit" = true;
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
