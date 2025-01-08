{pkgs, ...}: {
  stylix = {
    enable = true;
    autoEnable = false;

    image = ../../../assets/wallpapers/2.png;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    fonts = {
      sizes = {
        applications = 14;
        terminal = 16;
        desktop = 14;
        popups = 14;
      };
      monospace = {
        package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
        name = "JetBrainsMono Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };
    };

    cursor = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 24;
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
