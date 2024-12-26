{ config, pkgs, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.modesetting.enable = true;
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
  boot.kernelParams = [ "nvidia-drm.modeset=1" ];
}