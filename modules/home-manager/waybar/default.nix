{
  imports = [
    ./colors.nix
  ];

  programs.waybar = {
    enable = true;
    style = ./style.css;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        fixed-center = true;

        reload_style_on_change = true;
        margin-top = 8;
        margin-right = 8;
        margin-bottom = 0;
        margin-left = 8;

        modules-left = [ ];
        modules-center = [ "hyprland/workspaces" ];
        modules-right = [ ];

        "hyprland/workspaces" = {
          active-only = false;
          show-special = true;
          format = "{icon}";
          format-icons = {
            active = "";
            urgent = "!";
          };
        };
      };
    };
  };
}
