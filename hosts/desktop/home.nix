{ config, pkgs, username, timezone, ... }:

{
  home.stateVersion = "24.11";

  home.username = username;
  home.homeDirectory = "/home/${username}";

  environment.variables = {
    TZ = timezone;
  };

  programs.fish.enable = true;

  home.packages = with pkgs; [
    hyprland
    wl-clipboard
    waybar
  ];

  services.waybar.enable = true;

  home.file.".config/hypr/hyprland.conf".text = ''
    monitor = eDP-1, 1920x1080@144Hz, 0x0
    wallpaper = "${config.home.homeDirectory}/.config/wallpapers/my_wallpaper.jpg";
    decoration {
      rounding = 10;
      blur = yes;
    };
  '';
}
