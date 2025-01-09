{
  imports = [
    ./hardware-configuration.nix

    ../../system/boot.nix
    ../../system/nvidia.nix
    ../../system/bluetooth.nix
    ../../system/audio.nix
  ];

  system.stateVersion = "24.11";

  networking.networkmanager.enable = true;
  services.resolved.enable = true;
}
