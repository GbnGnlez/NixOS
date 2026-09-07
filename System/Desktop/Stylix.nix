# System/Desktop/Stylix.nix (o dentro de configuration.nix)

{
  pkgs,
  DarkTheme ? true,
  ...
}:

{
  stylix = {
    enable = true;
    polarity = if DarkTheme then "dark" else "light";

    # stylix.image es obligatorio para inicializar el módulo.
    # Usa una imagen local (.png o .jpg) en la misma carpeta o ruta absoluta en Nix.
image = ./5120x2880.png;

 
    # Opcional: define un esquema directo para evitar el cálculo automático de colores
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/breeze.yaml";

    cursor = {
      package = pkgs.bibata-cursors;
      name = if DarkTheme then "Bibata-Modern-Ice" else "Bibata-Modern-Classic";
      size = 24; # Tamaño estándar (16, 24, 32 o 48)
    };
  };
}
