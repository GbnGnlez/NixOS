# https://wiki.nixos.org/wiki/ONLYOFFICE

{ pkgs, ... }:

{
  # The set of packages to appear in the user environment.
  home.packages = with pkgs; [
    onlyoffice-desktopeditors # Office suite that combines text, spreadsheet and presentation editors allowing to create, view and edit local documents.
    corefonts # Microsoft's TrueType core fonts for the Web.
    vista-fonts # Some TrueType fonts from Microsoft Windows Vista (Calibri, Cambria, Candara, Consolas, Constantia, Corbel).
  ];

  # Attribute set of files to link into the user home.
  home.file = {
    ".local/share/fonts/corefonts".source = "${pkgs.corefonts}/share/fonts/truetype"; # Path of the source file or directory.
    ".local/share/fonts/vista-fonts".source = "${pkgs.vista-fonts}/share/fonts/truetype"; # Path of the source file or directory.
  };

  xdg.mimeApps = {
    enable = true; # Whether to manage $XDG_CONFIG_HOME/mimeapps.list.

    defaultApplications = {
      # Document
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = [
        "onlyoffice-desktopeditors.desktop"
      ]; # .docx
      "application/msword" = [ "onlyoffice-desktopeditors.desktop" ]; # .doc
      "application/vnd.oasis.opendocument.text" = [ "onlyoffice-desktopeditors.desktop" ]; # .odt

      # Spreadsheet
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = [
        "onlyoffice-desktopeditors.desktop"
      ]; # .xlsx
      "application/vnd.ms-excel" = [ "onlyoffice-desktopeditors.desktop" ]; # .xls
      "application/vnd.oasis.opendocument.spreadsheet" = [ "onlyoffice-desktopeditors.desktop" ]; # .ods

      # Presentation
      "application/vnd.openxmlformats-officedocument.presentationml.presentation" = [
        "onlyoffice-desktopeditors.desktop"
      ]; # .pptx
      "application/vnd.ms-powerpoint" = [ "onlyoffice-desktopeditors.desktop" ]; # .ppt
      "application/vnd.oasis.opendocument.presentation" = [ "onlyoffice-desktopeditors.desktop" ]; # .odp

      # PDF
      "application/pdf" = [ "onlyoffice-desktopeditors.desktop" ]; # .pdf
    };
  };
}
