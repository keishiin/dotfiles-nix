{ config, lib, pkgs, inputs, spicetify-nix, nixvim, ... }:
{

  home.username = "keishin";
  home.homeDirectory = "/home/keishin";

  home.stateVersion = "23.11";

  imports = [
    nixvim.homeManagerModules.nixvim
    spicetify-nix.homeManagerModule
    ./configs/zsh.nix
    ./configs/spicetify.nix
    ./configs/nixvim.nix
  ];

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    hello
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = { };

  home.sessionVariables = { };

  # allow spotify to be installed if you don't have unfree enabled already
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "spotify"
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
