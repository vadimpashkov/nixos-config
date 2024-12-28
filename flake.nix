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

    # Список хостов и пользователей
    hosts = [
      {
        hostname = "desktop";
        stateVersion = "24.11";
        users = [ "anisutsuri" ];
      }
    ];

    # Функция для генерации системы
    makeSystem = { hostname, stateVersion, users }: nixpkgs.lib.nixosSystem {
      system = system;
      specialArgs = {
        inherit inputs stateVersion hostname;
      };
      modules = [
        ./hosts/${hostname}/configuration.nix
        ./hosts/${hostname}/hardware-configuration.nix
        inputs.home-manager.nixosModules.default
      ] ++ (map (username: ./users/${username}/settings.nix) users);
    };

    # Функция для генерации Home Manager
    makeHome = { username }: home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      modules = [
        ./users/${username}/home.nix
      ];
      extraSpecialArgs = {
        inherit username;
      };
    };

  in {
    # Автоматическая генерация конфигурации NixOS
    nixosConfigurations = nixpkgs.lib.foldl' (configs: host:
      configs // {
        "${host.hostname}" = makeSystem host;
      }) {} hosts;

    # Автоматическая генерация конфигурации Home Manager
    homeConfigurations = nixpkgs.lib.foldl' (configs: host:
      let
        userConfigs = nixpkgs.lib.foldl' (userConfigs: username:
          userConfigs // {
            "${username}" = makeHome { username = username; };
          }
        ) {} host.users;
      in configs // userConfigs
    ) {} hosts;
  };
}
