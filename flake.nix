{
  description = "NixOS Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: let
    system = "x86_64-linux";
    hosts = [
      {
        hostname = "desktop";
        stateVersion = "24.11";
        users = [
          ./users/anisutsuri.nix
        ];
      }
    ];

    makeSystem = { hostname, stateVersion, users }: nixpkgs.lib.nixosSystem {
      system = system;
      specialArgs = {
        inherit inputs stateVersion hostname users;
      };
      modules = [
        ./hosts/${hostname}/configuration.nix
        ./hosts/${hostname}/hardware-configuration.nix
        inputs.home-manager.nixosModules.default
      ] ++ users;
    };

    makeHome = { userFile }: let
      username = nixpkgs.lib.basename userFile;
    in home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      extraSpecialArgs = {
        inherit inputs username;
      };
      modules = [
        userFile
      ];
    };

  in {
    nixosConfigurations = nixpkgs.lib.foldl' (configs: host:
      configs // {
        "${host.hostname}" = makeSystem host;
      }) {} hosts;

    homeConfigurations = nixpkgs.lib.foldl' (configs: host:
      let
        userConfigs = builtins.foldl' (userConfigs: userFile:
          userConfigs // {
            "${nixpkgs.lib.basename userFile}" = makeHome { userFile = userFile; };
          }
        ) {} host.users;
      in configs // userConfigs
    ) {} hosts;
  };
}
