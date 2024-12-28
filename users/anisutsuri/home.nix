{ pkgs, username, ... }:

{
  home.stateVersion = "24.11";

  home.username = username;
  home.homeDirectory = "/home/${username}";

  home.packages = with pkgs; [
    kitty
    wayland
    xwayland
    hyprland
    wl-clipboard
    waybar
  ];

  # TODO: Вынести в отдельный модуль
  home.file.".config/hypr/hyprland.conf".text = ''
    monitor = DP-1, 2560x1440@180Hz, 1080x0, 1
    monitor = DP-2, 1920x1080@144Hz, 0x0, 1, transform, 1
  '';

  # programs.home-manager.enable = true; - Точно тут а не в settings?
}
