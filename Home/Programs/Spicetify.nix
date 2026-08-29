# https://wiki.nixos.org/wiki/Spicetify-Nix

{ pkgs, SpicetifyNix, ... }:
let
  spicePkgs = SpicetifyNix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  programs.spicetify = {
    enable = true;

    # Catppuccin Mocha con acento Blue
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";

    # Opciones de tema adicionales (si deseas forzar el color de acento)
    customColorScheme = {
      accent = "89b4fa"; # Blue de Catppuccin Mocha
    };

    # Extensiones útiles
    enabledExtensions = with spicePkgs.extensions; [
      adblock
      hidePodcasts
      shuffle
    ];

    # Aplicaciones personalizadas
    enabledCustomApps = with spicePkgs.apps; [
      newReleases
      ncsVisualizer
    ];

    # Snippets CSS
    enabledSnippets = with spicePkgs.snippets; [
      rotatingCoverart
      pointer
    ];
  };
}
