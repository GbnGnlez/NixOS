# https://wiki.nixos.org/wiki/Visual_Studio_Code

{ pkgs, ... }:

{
  imports = [
    ./Git.nix
    ./NixIDE.nix
    ./GitHubActions.nix
  ];

  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;

    profiles.default.userSettings = {
      "git.enableSmartCommit" = true;
      "editor.fontFamily" = "JetBrainsMono Nerd Font";
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
