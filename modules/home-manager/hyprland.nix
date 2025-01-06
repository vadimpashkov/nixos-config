{pkgs, ...}: let
  waybarScript = pkgs.pkgs.writeShellScriptBin "waybar-launch" ''
    waybar &
  '';
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    ${waybarScript}/bin/waybar-launch
  '';
in {
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";
      "$terminal" = "kitty";
      "$fileManager" = "yazi";
      "$menu" = "rofi -show drun";
      "$bar" = "${waybarScript}/bin/waybar-launch";
      # "$wallpapers" = "~/.local/bin/swww-launch.sh";

      env = [
        "LIBVA_DRIVER_NAME,nvidia"
        "XDG_SESSION_TYPE,wayland"
        "WLR_NO_HARDWARE_CURSORS,1"
      ];

      monitor = [
        "DP-1, 2560x1440@160Hz, 1080x0, 1"
        "DP-2, 1920x1080@160Hz, 0x0, 1, transform, 1"
      ];

      # exec-once = [
      # "~/.local/bin/waybar-launch.sh"
      # "~/.local/bin/swww-launch.sh"
      # "[workspace 1 silent] google-chrome-stable"
      # "[workspace 2 silent] telegram-desktop"
      # "[workspace 3 silent] $terminal"
      # ];

      exec-once = "${startupScript}/bin/start";

      general = {
        gaps_in = 4;
        gaps_out = 8;

        border_size = 2;

        "col.active_border" = "rgba(7287fdff)";
        "col.inactive_border" = "rgba(595959aa)";

        resize_on_border = false;

        # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        allow_tearing = false;

        layout = "dwindle";
      };

      master = {
        new_status = "master";
      };

      input = {
        kb_layout = "us,ru";
        kb_variant = ",";
        kb_model = "";
        kb_options = "grp:caps_toggle";

        follow_mouse = 0;
        sensitivity = -0.7;
        accel_profile = "flat";

        touchpad = {
          natural_scroll = false;
        };
      };

      device = {
        name = "compx-vgn-dragonfly-4k-receiver-consumer-control-1";
        sensitivity = -1.0;
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      gestures = {
        workspace_swipe = false;
      };

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };

      animations = {
        enabled = true;

        # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      decoration = {
        rounding = 10;

        active_opacity = 1.0;
        inactive_opacity = 1.0;

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };

        blur = {
          enabled = true;
          size = 3;
          passes = 1;

          vibrancy = 0.1696;
        };
      };

      bind =
        [
          "$mod, Return, exec, $terminal"
          "$mod, Delete, exit"
          "$mod, C, killactive"
          "$mod, E, exec, $fileManager"
          "$mod, V, togglefloating"
          "$mod, SPACE, exec, $menu"
          "$mod, P, pseudo, # dwindle"
          "$mod, T, togglesplit, # dwindle"
          "$mod SHIFT, B, exec, $bar"

          "$mod, L, movefocus, l"
          "$mod, H, movefocus, r"
          "$mod, K, movefocus, u"
          "$mod, J, movefocus, d"

          ", Print, exec, ~/.local/bin/screenshot.sh screen"
          "$mod, Print, exec, ~/.local/bin/screenshot.sh area"

          "$mod, S, togglespecialworkspace, magic"
          "$mod, S, movetoworkspace, +0"
          "$mod, S, togglespecialworkspace, magic"
          "$mod, S, movetoworkspace, special:magic"
          "$mod, S, togglespecialworkspace, magic"

          "$mod, mouse_down, workspace, e+1"
          "$mod, mouse_up, workspace, e-1"
        ]
        ++ (builtins.concatLists (
          builtins.genList (
            i: let
              ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          )
          9
        ));

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      windowrulev2 = [
        # Заврещаем развертывание (максимизацию) для приложений
        "suppressevent maximize, class:.*"

        # Делаем Picture in picture от Google Chrome запининым на всех экранах
        "float, title:^(Picture in picture)$"
        "pin, title:^(Picture in picture)$"
        "noborder, title:^(Picture in picture)$"
        "keepaspectratio, title:^(Picture in picture)$"
        "size 320 180, title:^(Picture in picture)$"
        "move onscreen 100%-328 100%-188, title:^(Picture in picture)$"
        "animation popin 80%, title:^(Picture in picture)$"

        # "float, class:^(ComTeam)$, title:^(ComTeam)$"
        # "animation popin 80%, class:^(ComTeam)$, title:^(ComTeam)$"
        # "pin, class:^(ComTeam)$, title:^(ComTeam)$"
        # "noborder, class:^(ComTeam)$, title:^(ComTeam)$"
        # "keepaspectratio, class:^(ComTeam)$, title:^(ComTeam)$"
        # "fakefullscreen, class:^(ComTeam)$, title:^(ComTeam)$"
        # "size 320 180, class:^(ComTeam)$, title:^(ComTeam)$"
        # "move onscreen 100%-328 56, class:^(ComTeam)$, title:^(ComTeam)$"
        # "animation popin 80%, class:^(ComTeam)$, title:^(ComTeam)$"
      ];
    };
  };
}
