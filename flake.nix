{
  description = "NixOS Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    hyprlock.url = "github:hyprwm/Hyprlock";
    stylix.url = "github:danth/stylix/release-24.11";
    swww.url = "github:LGFae/swww";
    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    stylix,
    ...
  } @ inputs: let
    inherit (self) outputs;

    users = {
      anisutsuri = "anisutsuri";
    };

    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};

    globalConfig = import ./config.nix;
  in {
    globalConfig = globalConfig;
    userConfig = import "${globalConfig.dir.user}/config.nix" {inherit pkgs;};

    formatter = pkgs.alejandra;

    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;

    nixosConfigurations = {
      "desktop" = nixpkgs.lib.nixosSystem {
        modules = [
          ./profiles/desktop
          (import globalConfig.dir.user {
            pkgs = pkgs;
            username = globalConfig.username;
          })
          (import ./system/global.nix {inherit pkgs outputs;})
          inputs.home-manager.nixosModules.default
        ];
        specialArgs = {inherit inputs outputs;};
      };
    };

    homeConfigurations = {
      ${users.anisutsuri} = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs;
        modules = [
          stylix.homeManagerModules.stylix
          ./users/${users.anisutsuri}/home.nix
        ];
        extraSpecialArgs = {
          inputs = inputs;
          outputs = outputs;
          username = users.anisutsuri;
        };
      };
    };
  };
}
