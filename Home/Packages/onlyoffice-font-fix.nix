# onlyoffice-font-fix.nix

{ config, pkgs, ... }:

{
  # Expose installed fonts under /run/current-system/sw/share/X11/fonts
  fonts.fontDir.enable = true;

  # OnlyOffice font fix
  nixpkgs.overlays = [
    (final: prev: {
      onlyoffice-desktopeditors = prev.buildFHSEnv (
        prev.onlyoffice-desktopeditors.passthru.args
        // {
          extraBwrapArgs = (prev.onlyoffice-desktopeditors.passthru.args.extraBwrapArgs or [ ]) ++ [
            # Bind mount host system fonts into the FHS container's /usr/share/fonts:
            "--ro-bind"
            "/usr/share/fonts"
            "/usr/share/fonts"
          ];
        }
      );
    })
  ];
}
