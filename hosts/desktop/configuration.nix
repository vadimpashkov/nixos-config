{ config, pkgs, hostname, stateVersion, ... }:

{
  imports = [
    ../../modules/global-settings.nix
    ../../modules/nvidia.nix
    ../../modules/wayland.nix
    ../../modules/packages.nix
  ];

  networking.hostName = hostname;
  system.stateVersion = stateVersion;
}
