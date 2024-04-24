{
  config,
  pkgs,
  inputs,
  nixvim,
  ...
}: {
  # using nixvim instead of what ever i was doing before
  programs.nixvim = {
    enable = true;
    globals.mapleader = " ";

    colorschemes.catppuccin = {
      enable = true;
      settings = {
        transparent_background = true;
        flavour = "mocha";
        no_underline = true;
        integrations = {
          cmp = true;
          nvimtree = true;
          treesitter = true;
        };
      };
    };

    plugins = {
      lualine.enable = true;
      oil.enable = true;
      trouble.enable = true;

      lspsaga = {
        enable = true;
        beacon = {
          enable = true;
        };
        ui = {
          border = "rounded";
          codeAction = "💡";
        };
        hover = {
          openCmd = "!kitty -e";
          openLink = "firefox";
        };
        diagnostic = {
          borderFollow = true;
          diagnosticOnlyCurrent = false;
          showCodeAction = true;
        };
        symbolInWinbar.enable = true; # Breadcrumbs
        codeAction = {
          extendGitSigns = false;
          showServerName = true;
          onlyInCursor = true;
          numShortcut = true;
          keys = {
            exec = "<CR>";
            quit = ["<Esc>" "q"];
          };
        };
        lightbulb = {
          enable = false;
          sign = false;
          virtualText = true;
        };
        implement.enable = false;
        rename = {
          autoSave = false;
          keys = {
            exec = "<CR>";
            quit = ["<C-k>" "<Esc>"];
            select = "x";
          };
        };
        outline = {
          autoClose = true;
          autoPreview = true;
          closeAfterJump = true;
          layout = "normal"; # normal or float
          winPosition = "right"; # left or right
          keys = {
            jump = "e";
            quit = "q";
            toggleOrJump = "o";
          };
        };
        scrollPreview = {
          scrollDown = "<C-f>";
          scrollUp = "<C-b>";
        };
      };

      none-ls = {
        enable = true;
        enableLspFormat = true;
        updateInInsert = false;
        sources = {
          code_actions = {
            gitsigns.enable = true;
            statix.enable = true;
          };
          diagnostics = {
            statix.enable = true;
            yamllint.enable = true;
          };
          formatting = {
            alejandra.enable = true;
            black = {
              enable = true;
              withArgs = ''
                {
                  extra_args = { "--fast" },
                }
              '';
            };
            prettier = {
              enable = true;
              disableTsServerFormatter = true;
              withArgs = ''
                {
                  extra_args = { "--no-semi", "--single-quote" },
                }
              '';
            };
            stylua.enable = true;
            yamlfmt.enable = true;
          };
        };
      };

      neo-tree = {
        enable = true;
        enableGitStatus = true;
        enableModifiedMarkers = true;
        example.window.mappings = {
          "<leader>" = "toggle_node";
          "e" = ":Neotree toggle float";
          d = "open neo tree";
        };
      };

      treesitter = {
        enable = true;
        indent = true;
        folding = true;
        nixvimInjections = true;
        grammarPackages = with pkgs.vimPlugins.nvim-treesitter-parsers; [
          nix
          rust
          python
          markdown
        ];
      };

      telescope = {
        enable = true;
        highlightTheme = "catppuccin-mocha";
        extensions = {
          file-browser.enable = true;
          fzf-native.enable = true;
        };
        settings.defaults = {
          layout_config.horizontal.prompt_position = "top";
          sorting_strategy = "ascending";
        };
      };

      conform-nvim = {
        enable = true;
        formatOnSave = {
          lspFallback = true;
          timeoutMs = 500;
        };
        notifyOnError = true;
        formattersByFt = {
          python = ["black"];
          nix = ["alejandra"];
          markdown = [["prettierd" "prettier"]];
          rust = ["rustfmt"];
        };
      };

      lsp-format = {enable = true;};
      lsp = {
        enable = true;
        servers = {
          nil_ls.enable = true;
          marksman.enable = true;
          ltex.enable = true;
          pyright.enable = true;
          gleam.enable = true;
          rust-analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
          };
        };
      };

      lspkind = {
        enable = true;
        extraOptions = {
          maxwidth = 50;
          ellipsis_char = "...";
        };
      };

      luasnip = {
        enable = true;
        extraConfig = {
          enable_autosnippets = true;
          store_selection_keys = "<Tab>";
        };
        fromVscode = [
          {
            lazyLoad = true;
            paths = "${pkgs.vimPlugins.friendly-snippets}";
          }
        ];
      };

      cmp = {
        enable = true;
        settings = {
          autoEnableSources = true;
          experimental.ghost_text = true;
          sources = [
            {name = "nvim_lsp";}
            {name = "path";}
            {name = "buffer";}
            {name = "luasnip";}
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
