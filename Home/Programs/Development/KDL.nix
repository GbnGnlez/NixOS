{ pkgs, ... }:

let
  kdl-v1 = pkgs.vscode-utils.buildVscodeExtension {
    pname = "kdl-v1";
    version = "1.4.1";

    vscodeExtUniqueId = "kdl-org.kdl-v1";
    vscodeExtPublisher = "kdl-org";
    vscodeExtName = "kdl-v1";

    src = pkgs.fetchurl {
      url = "https://marketplace.visualstudio.com/_apis/public/gallery/publishers/kdl-org/vsextensions/kdl-v1/1.4.1/vspackage";
      hash = "sha256-xE/Zerw7/ZyI5JYq7PaF5UjMxhINeydkUSz+qR7g4AM=";
    };
  };
in
{
  programs.vscode.profiles.default.extensions = [
    kdl-v1
  ];
}
