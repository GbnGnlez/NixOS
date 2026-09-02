{ pkgs, ... }:

let
  kdl-v1 = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      publisher = "kdl-org";
      name = "kdl-v1";
      version = "1.4.1";
      hash = "sha256-9hC+0GEj6cxCgPk2R9OMPUrkqXaztV7xDLrQYPqAedg=";
    };
  };
in
{
  home.packages = with pkgs; [
    kdlfmt
  ];

  programs.vscode = {
    profiles.default.extensions = [
      kdl-v1
    ];

    profiles.default.userSettings = {
      "[kdl]" = {
        "editor.formatOnSave" = true;
      };
    };
  };
}
