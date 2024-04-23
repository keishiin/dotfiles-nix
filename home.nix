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


  # using nixvim instead of what ever i was doing before
  programs.nixvim = {
    enable = true;
    globals.mapleader = " ";

    colorschemes.catppuccin.enable = true;

    plugins = {
      lualine.enable = true;
      telescope.enable = true;
      oil.enable = true;
      treesitter.enable = true;
      luasnip.enable = true;

      lsp.servers = {
        nixd = {
          enable = true;
          settings.formatting.command = "nixpkgs-fmt";
        };

        rust-analyzer = {
          enable = true;
          installCargo = true;
          installRustc = true;
        };
      };

      cmp = {
        enable = true;
        autoEnableSources = true;
        settings.sources = [
          { name = "nvim_lsp"; }
          { name = "path"; }
          { name = "buffer"; }
          { name = "luasnip"; }
        ];

        settings.mapping = {
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-d>" = "cmp.mapping.scroll_docs(-4)";
          "<C-e>" = "cmp.mapping.close()";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
          "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
        };
      };
    };

    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      cursorline = true;
      swapfile = false;
      updatetime = 50;
    };
  };


  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
