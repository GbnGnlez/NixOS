# https://wiki.nixos.org/wiki/Spicetify-Nix
# https://spicetify.app/docs/getting-started

{
  pkgs,
  Spicetify,
  DarkTheme,
  Color,
  ...
}:

let
  spicePkgs = Spicetify.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  programs.spicetify = {
    enable = true;

    # theme = spicePkgs.themes.default;
    # colorSpotifyScheme = Color;

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
