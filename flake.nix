{
  description = "NixOS Config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: let
    system = "x86_64-linux";
    hosts = [
      { hostname = "desktop"; stateVersion = "24.11"; users = [
        { username = "anisutsuri"; timezone = "Europe/Moscow"; }
      ]; }
    ];

    makeSystem = { hostname, stateVersion, users }: nixpkgs.lib.nixosSystem {
      system = system;
      specialArgs = {
        inherit inputs stateVersion hostname users;
      };
      modules = [
        ./hosts/${hostname}/configuration.nix
        ./hosts/${hostname}/hardware-configuration.nix
        ./modules/users.nix
      ];
    };

    makeHome = { username, timezone }: home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      extraSpecialArgs = {
        inherit inputs username timezone;
      };
      modules = [
        ./hosts/${username}/home.nix
      ];
    };

  in {
    nixosConfigurations = nixpkgs.lib.foldl' (configs: host:
      configs // {
        "${host.hostname}" = makeSystem host;
      }) {} hosts;

    homeConfigurations = nixpkgs.lib.foldl' (configs: host:
      let
        userConfigs = builtins.foldl' (userConfigs: user:
          userConfigs // {
            "${user.username}" = makeHome user;
          }
        ) {} host.users;
      in configs // userConfigs
    ) {} hosts;
  };
}
