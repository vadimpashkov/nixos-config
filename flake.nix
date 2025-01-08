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
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      system = system;
      config.allowUnfree = true;
    };

    username = "anisutsuri";

    hosts = [
      {
        hostname = "desktop";
        stateVersion = "24.11";
      }
    ];

    makeSystem = {
      hostname,
      stateVersion,
      username,
    }:
      nixpkgs.lib.nixosSystem {
        system = system;
        specialArgs = {
          inherit inputs pkgs stateVersion hostname username;
        };
        modules = [
          ./hosts/${hostname}/configuration.nix
          ./hosts/${hostname}/hardware-configuration.nix
          ./modules/nixos/global.nix
          ./users/${username}
          inputs.home-manager.nixosModules.default
        ];
      };
  in {
    nixosConfigurations =
      nixpkgs.lib.foldl' (
        configs: host:
          configs
          // {
            "${host.hostname}" = makeSystem {
              hostname = host.hostname;
              stateVersion = host.stateVersion;
              username = username;
            };
          }
      ) {}
      hosts;

    homeConfigurations = {
      "anisutsuri" = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs;
        modules = [
          stylix.homeManagerModules.stylix
          ./users/anisutsuri/home.nix
        ];
        extraSpecialArgs = {
          inherit inputs username;
        };
      };
    };
  };
}
