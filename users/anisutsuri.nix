{ config, pkgs, lib, ... }:

let
  username = lib.basename (__file__);
in
{
  users.users.${username} = {
    isNormalUser = true;
    home = "/home/${username}";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  environment.variables = {
    TZ = "Europe/Moscow";
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "ru_RU.UTF-8";
      LC_IDENTIFICATION = "ru_RU.UTF-8";
      LC_MEASUREMENT = "ru_RU.UTF-8";
      LC_MONETARY = "ru_RU.UTF-8";
      LC_NAME = "ru_RU.UTF-8";
      LC_NUMERIC = "ru_RU.UTF-8";
      LC_PAPER = "ru_RU.UTF-8";
      LC_TELEPHONE = "ru_RU.UTF-8";
      LC_TIME = "ru_RU.UTF-8";
    };
  };

  home = {
    stateVersion = "24.11";
    packages = with pkgs; [
      wayland
      xwayland
      hyprland
      wl-clipboard
      waybar
    ];
  };

  programs.home-manager.enable = true;

  # TODO: Вынести в отдельный модуль
  home.file.".config/hypr/hyprland.conf".text = ''
    monitor = eDP-1, 2560x1440@180Hz, 0x0, 1
    monitor = eDP-2, 1920x1080@144Hz, -2560x0, 1, transform, 90
  '';
}
