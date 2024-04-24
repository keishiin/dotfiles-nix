{ config, pkgs, inputs, nixvim, ... }:

{

  # using nixvim instead of what ever i was doing before
  programs.nixvim = {
    enable = true;
    globals.mapleader = " ";

    colorschemes.catppuccin = {
      enable = true;
      settings.transparent_background = true;
    };

    plugins = {
      lualine.enable = true;
      telescope.enable = true;
      oil.enable = true;
      treesitter.enable = true;
      luasnip.enable = true;

      conform-nvim = {
        enable = true;
        formatOnSave = {
          lspFallback = true;
          timeoutMs = 500;
        };
        notifyOnError = true;
        formattersByFt = {
          python = [ "black" ];
          nix = [ "alejandra" ];
          markdown = [ [ "prettierd" "prettier" ] ];
          rust = [ "rustfmt" ];
        };
      };
      
      lsp.servers = {
        nixd = {
          enable = true;
          settings.formatting.command = "nixpkgs-fmt";
        };

        rust-analyzer = {
          enable = true;
          installCargo = false;
          installRustc = false;
        };
      };

      cmp = {
        enable = true;
        settings = {
          autoEnableSources = true;
          experimental.ghost_text = true;
          sources = [
            { name = "nvim_lsp"; }
            { name = "path"; }
            { name = "buffer"; }
            { name = "luasnip"; }
          ];

          mapping = {
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

      cmp-buffer.enable = true;
      cmp-cmdline.enable = true; 
      cmp-emoji.enable = true;
      cmp_luasnip.enable = true; 
      cmp-nvim-lsp.enable = true; 
      cmp-path.enable = true;
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
}
