{ config, pkgs, hostname, stateVersion, ... }:

{
  imports = [
    ../../modules/global-settings.nix
    ../../modules/packages.nix
    ../../modules/boot.nix
    ../../modules/nvidia.nix
    ../../modules/hyprland.nix
  ];

  networking.hostName = hostname;
  system.stateVersion = stateVersion;

  networking.networkmanager.enable = true;
}
