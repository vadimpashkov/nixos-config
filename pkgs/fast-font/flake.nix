{
  description = "Fast-Font package";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs";

  outputs = {nixpkgs, ...}: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
  in {
    packages.${system} = {
      fastSerif = pkgs.stdenv.mkDerivation {
        name = "Fast-Serif";
        src = ./assets/Fast_Serif.ttf;
        dontUnpack = true;
        installPhase = ''
          mkdir -p $out/share/fonts
          cp $src $out/share/fonts/
        '';
      };

      fastMono = pkgs.stdenv.mkDerivation {
        name = "Fast-Mono";
        src = ./assets/Fast_Mono.ttf;
        dontUnpack = true;
        installPhase = ''
          mkdir -p $out/share/fonts
          cp $src $out/share/fonts/
        '';
      };

      fastSans = pkgs.stdenv.mkDerivation {
        name = "Fast-Sans";
        src = ./assets/Fast_Sans.ttf;
        dontUnpack = true;
        installPhase = ''
          mkdir -p $out/share/fonts
          cp $src $out/share/fonts/
        '';
      };

      fastSansDotted = pkgs.stdenv.mkDerivation {
        name = "Fast-Sans-Dotted";
        src = ./assets/Fast_Sans_Dotted.ttf;
        dontUnpack = true;
        installPhase = ''
          mkdir -p $out/share/fonts
          cp $src $out/share/fonts/
        '';
      };
    };
  };
}
