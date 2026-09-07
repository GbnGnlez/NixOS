# https://wiki.nixos.org/wiki/Spicetify-Nix
# https://spicetify.app/docs/getting-started

{
  pkgs,
  Spicetify,
  ...
}:

let
  spicePkgs = Spicetify.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  programs.spicetify = {
    enable = true;

    enabledExtensions = with spicePkgs.extensions; [
      adblock
      hidePodcasts
      spicyLyrics
      shuffle
    ];

    enabledCustomApps = with spicePkgs.apps; [
    ];

    enabledSnippets = with spicePkgs.snippets; [
      pointer
      hideLyricsButton
      hideMiniPlayerButton
    ];
  };
}
