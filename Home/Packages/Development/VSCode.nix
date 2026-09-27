# https://wiki.nixos.org/wiki/Visual_Studio_Code

{ pkgs, ... }:

{
  imports = [
    ./Git.nix
    ./GitHubActions.nix
    ./NixIDE.nix
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
      "text/*" = [ "code.desktop" ];
      "application/x-yaml" = [ "code.desktop" ];
    };

  };
}
