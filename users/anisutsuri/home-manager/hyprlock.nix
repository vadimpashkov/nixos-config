{config, ...}: {
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        grace = 0;
        ignore_empty_input = true;
      };

      background = {
        blur_passes = 3;
        blur_size = 10;
        brightness = 1.0;
        contrast = 1.0;
        noise = 0.02;
      };

      input-field = {
        monitor = "";
        size = "256, 48";
        outline_thickness = 0;
        dots_size = 0.26;
        dots_spacing = 0.64;
        dots_center = true;
        fade_on_empty = true;
        placeholder_text = "Password...";
        hide_input = false;
        position = "0, 48";
        halign = "center";
        valign = "bottom";
      };

      label = [
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$(date +'%H:%M:%S')"'';
          color = "#${config.lib.stylix.colors.base05}";

          font_size = "64";
          font_family = "JetBrainsMono Nerd Font";

          position = "0, 30"; # 64 - height; 32 - gap (/ 2)
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = ''cmd[update:18000000] echo "<b>$(date +'%A, %-d %B %Y')</b>"'';
          color = "#${config.lib.stylix.colors.base05}";

          font_size = "24";
          font_family = "JetBrainsMono Nerd Font";

          position = "0, -55"; # 24 - height; 64 - time height; 32 - gap (/ 2);
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
