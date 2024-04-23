{ config, pkgs, ... }:

{

  # some zsh stuff
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
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

}
