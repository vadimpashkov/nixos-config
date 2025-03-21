{ pkgs, ... }:

{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    package = pkgs.bluez;
  };

  services.blueman.enable = true;

  environment.systemPackages = with pkgs; [
    bluez
    bluez-tools
  ];
}
