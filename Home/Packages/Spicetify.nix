# https://wiki.nixos.org/wiki/Spicetify-Nix
# https://spicetify.app/docs/getting-started

{
  pkgs,
  Spicetify,
  DarkTheme,
  ...
}:

let
  spicePkgs = Spicetify.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in

{
  programs.spicetify = {
    enable = true;

    # Asigna dinámicamente el flavor ("mocha" si es oscuro, "latte" si es claro)
    # theme = spicePkgs.themes.catppuccin;
    # colorScheme = if DarkTheme then "mocha" else "latte";

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
