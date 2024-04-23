{
  description = "osconfigs";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/HyprLand";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    spicetify-nix.url = "github:the-argus/spicetify-nix";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, spicetify-nix, nixvim, ... } @ inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        KEISHIN = lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [ ./configuration.nix ];
        };
      };
      homeConfigurations = {
        keishin = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs; inherit spicetify-nix; inherit nixvim; };
          modules = [ ./home.nix ];
        };
      };
    };
}


