{ config, pkgs, ... }:

{
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    wayland
    xwayland
    hyprland
    wl-clipboard
    waybar
  ];

  # TODO: Вынести в отдельный модуль
  home.file.".config/hypr/hyprland.conf".text = ''
    monitor = eDP-1, 2560x1440@180Hz, 0x0, 1
    monitor = eDP-2, 1920x1080@144Hz, -2560x0, 1, transform, 90
  '';

  # programs.home-manager.enable = true; - Точно тут а не в settings?
}
