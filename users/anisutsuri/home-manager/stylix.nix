{
  pkgs,
  inputs,
  ...
}: {
  stylix = {
    enable = true;
    autoEnable = false;

    image = ../assets/wallpapers/1.png;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    fonts = {
      sizes = {
        applications = 16;
        terminal = 16;
        desktop = 16;
        popups = 16;
      };
      monospace = {
        package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
        name = "JetBrainsMono Nerd Font Mono";
      };
      sansSerif = {
        package = inputs.fast-font.packages.x86_64-linux.fastSans;
        name = "Fast-Sans";
      };
      serif = {
        package = inputs.fast-font.packages.x86_64-linux.fastSerif;
        name = "Fast-Serif";
      };
    };

    cursor = {
      name = "Bibata-Original-Ice";
      package = pkgs.bibata-cursors;
      size = 20;
    };

    opacity = {
      applications = 1.0;
      terminal = 1.0;
      desktop = 1.0;
      popups = 1.0;
    };

    targets = {
      bat.enable = true;
      fzf.enable = true;
      lazygit.enable = true;
      tmux.enable = true;
      yazi.enable = true;
      kitty.enable = true;
      nixvim.enable = true;
      hyprland.enable = true;
      hyprlock.enable = true;
    };
  };
}
