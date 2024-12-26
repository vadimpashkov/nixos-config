{ config, pkgs, ... }:

{
  services.wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
  };

  programs.dunst.enable = true;
}