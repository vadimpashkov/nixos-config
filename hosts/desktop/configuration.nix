{ hostname, stateVersion, ... }:

{
  imports = [
    ../../modules/nixos/global-settings.nix
    ../../modules/nixos/packages.nix
    ../../modules/nixos/boot.nix
    ../../modules/nixos/nvidia.nix
    ../../modules/nixos/bluetooth.nix
    ../../modules/nixos/audio.nix
  ];

  networking.hostName = hostname;
  system.stateVersion = stateVersion;

  networking.networkmanager.enable = true;
  services.resolved.enable = true;
}
