{ pkgs, ... }:

let
  kdl-v1 = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      publisher = "kdl-org";
      name = "kdl-v1";
      version = "1.4.1";
      hash = "sha256-xE/Zerw7/ZyI5JYq7PaF5UjMxhINeydkUSz+qR7g4AM=";
    };
  };
in
{
  programs.vscode.profiles.default.extensions = [
    kdl-v1
  ];
}
