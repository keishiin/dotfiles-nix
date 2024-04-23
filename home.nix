{ config, lib, pkgs, inputs, spicetify-nix, nixvim, ... }:
let
  spicePkgs = spicetify-nix.packages.${pkgs.system}.default;

in
{

  home.username = "keishin";
  home.homeDirectory = "/home/keishin";

  home.stateVersion = "23.11";

  imports = [ nixvim.homeManagerModules.nixvim spicetify-nix.homeManagerModule ];

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

  # using nixvim instead of what ever i was doing before
  programs.nixvim = {
    enable = true;

    colorschemes.catppuccin.enable = true;

    plugins = {
      lualine.enable = true;

      lsp.servers = {
	nixd = {
	  enable = true;
	};

	rust-analyzer = {
	  enable = true;
	  installCargo = true;
	  installRustc = true;
	};
      };
    };

    options = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
    };
  };

  # some zsh stuff
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    initExtra = ''
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
      alias dotfiles="cd ~/.dotfiles"
      alias config="cd ~/.config"
      alias rbd="sudo nixos-rebuild switch --flake .#KEISHIN"
      alias hm="home-manager switch --flake ." 
    '';
    zplug = {
      enable = true;
      plugins = [{
        name = "romkatv/powerlevel10k";
        tags = [ "as:theme" "depth:1" ];
      }];
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
