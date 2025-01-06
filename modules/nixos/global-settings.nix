{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  environment = {
    systemPackages = [pkgs.home-manager];
    sessionVariables = {
      TERMINAL = "kitty";
      VISUAL = "nvim";
      EDITOR = "nvim";
    };
  };
}
