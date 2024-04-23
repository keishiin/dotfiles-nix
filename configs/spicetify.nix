{ pkgs, spicetify-nix, ... }:

let
  spicePkgs = spicetify-nix.packages.${pkgs.system}.default;

in
{
  # configure spicetify :)
  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";

    enabledExtensions = with spicePkgs.extensions; [
      fullAppDisplay
      shuffle
      hidePodcasts
    ];
  };

}
