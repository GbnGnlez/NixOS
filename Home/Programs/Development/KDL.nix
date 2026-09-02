{ pkgs, ... }:

let
  kdl-v1 = pkgs.vscode-utils.buildVscodeExtension {
    pname = "kdl-v1";
    version = "1.4.1";

    src = pkgs.fetchurl {
      url = "https://marketplace.visualstudio.com/_apis/public/gallery/publishers/kdl-org/vsextensions/kdl-v1/1.4.1/vspackage";
      hash = pkgs.lib.fakeHash;
    };

    vscodeExtPublisher = "kdl-org";
    vscodeExtName = "kdl-v1";
  };
in
{
  programs.vscode.profiles.default.extensions = [
    kdl-v1
  ];
}
