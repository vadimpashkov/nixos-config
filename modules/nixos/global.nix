{
  pkgs,
  username,
  ...
}: {
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  environment.systemPackages = [
    pkgs.home-manager
  ];

  services.getty.autologinUser = username;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "—delete-older-than 30d";
  };
}
