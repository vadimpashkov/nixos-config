{
  description = "A simple screenshot tool package";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = {nixpkgs, ...}: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
  in {
    packages.${system} = {
      screenshot = pkgs.writeShellApplication {
        name = "screenshot";
        runtimeInputs = with pkgs; [grimblast swappy libnotify];
        text = builtins.readFile ./screenshot.sh;
      };
    };
  };
}
