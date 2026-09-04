# https://wiki.nixos.org/wiki/Spicetify-Nix
# https://spicetify.app/docs/getting-started

{
  pkgs,
  Spicetify,
  Theme,
  ...
}:

let
  spicePkgs = Spicetify.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in

{
  programs.spicetify = {
    enable = true;

    # Asigna dinámicamente el flavor ("mocha" o "latte")
    theme = spicePkgs.themes.breeze;
    colorScheme = Theme;

    enabledExtensions = with spicePkgs.extensions; [
      adblock
      hidePodcasts
      shuffle
    ];

    enabledCustomApps = with spicePkgs.apps; [
      newReleases
      ncsVisualizer
    ];

    enabledSnippets = with spicePkgs.snippets; [
      rotatingCoverart
      pointer
    ];
  };
}
