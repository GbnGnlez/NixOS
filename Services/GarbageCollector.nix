{ ... }:

{
  nix.gc = {
    automatic = true; # Automatically run the garbage collector at a specific time.
    dates = "daily"; # How often or when garbage collection is performed.
    options = "-d"; # Options given to nix-collect-garbage when the garbage collector is run automatically.
  };

  nix.settings.auto-optimise-store = true; # If set to true, Nix automatically detects files in the store that have identical contents, and replaces them with hard links to a single copy.
}
