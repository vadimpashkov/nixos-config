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
        users = [ "anisutsuri" ];
      }
    ];

    makeSystem = { hostname, stateVersion, users }: nixpkgs.lib.nixosSystem {
      system = system;
      specialArgs = {
        inherit inputs stateVersion hostname;
      };
      modules = [
        ./hosts/${hostname}/configuration.nix
        ./hosts/${hostname}/hardware-configuration.nix
        inputs.home-manager.nixosModules.default
      ] ++ map (username: {
        imports = [ ./users/${username}/settings.nix ];
        username = username;
      }) users;
    };

    makeHome = username: home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      modules = [
        ./users/${username}/home.nix
      ];
    };

  in {
    nixosConfigurations = nixpkgs.lib.foldl' (configs: host:
      configs // {
        "${host.hostname}" = makeSystem host;
      }) {} hosts;

    homeConfigurations = nixpkgs.lib.foldl' (configs: host:
      let
        userConfigs = nixpkgs.lib.foldl' (userConfigs: username:
          userConfigs // {
            "${username}" = makeHome username;
          }
        ) {} host.users;
      in configs // userConfigs
    ) {} hosts;
  };
}
