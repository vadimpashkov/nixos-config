{
  description = "VPN Manager Package";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = {nixpkgs, ...}: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
  in {
    packages.${system}.default = pkgs.writeShellApplication {
      name = "vpn-manager";
      runtimeInputs = with pkgs; [wireguard-tools openvpn];
      text = builtins.readFile ./vpn-manager.sh;
    };
  };
}
