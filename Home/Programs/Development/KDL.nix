{ pkgs, ... }:

let
  kdl-v1 = pkgs.vscode-utils.buildVscodeExtension {
    pname = "kdl-v1";
    version = "1.4.1";

    vscodeExtUniqueId = "kdl-org.kdl-v1";

    src = pkgs.fetchurl {
      url = "https://marketplace.visualstudio.com/_apis/public/gallery/publishers/kdl-org/vsextensions/kdl-v1/1.4.1/vspackage";
      hash = pkgs.lib.fakeHash;
    };
  };
in
{
  programs.vscode.profiles.default.extensions = [
    kdl-v1
  ];
}
