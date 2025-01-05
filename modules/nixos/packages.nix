{ pkgs, ... }:

let
  basePackages = with pkgs; [
  ];

  devTools = with pkgs; [
    git
    vim
  ];
in
{
  environment.systemPackages = basePackages ++ devTools;
}
