{
  description = "NixOS and Home-Manager Updater";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = {nixpkgs, ...}: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
  in {
    packages.${system}.default = pkgs.writeShellApplication {
      name = "updater";
      text = builtins.readFile ./updater.sh;
    };
  };
}
