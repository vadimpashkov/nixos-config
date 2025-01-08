{
  services.xserver.videoDrivers = ["nvidia"];
  hardware = {
    nvidia = {
      modesetting.enable = true;
      open = false;
    };
    graphics.enable = true;
  };
}
