{ config, pkgs, ... }:

let
  basePackages = with pkgs; [
    git
  ];

  devTools = with pkgs; [
    vim
  ];
in
{
  environment.systemPackages = basePackages ++ devTools;
}
