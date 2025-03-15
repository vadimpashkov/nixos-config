{
  pkgs,
  inputs,
  ...
}: let
  # startupScript =
  #   pkgs.pkgs.writeShellScriptBin "start" ''
  #   '';
  # screenShotScript = pkgs.writeShellScriptBin "screenshot" ''
  #   SCREENSHOT_FOLDER_NAME="Pictures/Screenshots/$(date +%d-%m-%Y)/"
  #   OUTPUT_FOLDER="$HOME/$SCREENSHOT_FOLDER_NAME"
  #   SCREENSHOT_NAME="$(date +%H-%M-%S).png"
  #   OUTPUT="$OUTPUT_FOLDER$SCREENSHOT_NAME"
  #   SWAPPY_CONFIG_PATH="$CONFIG_DIR/swappy/config"
  #   DEFAULT_SWAPPY_CONFIG=$(cat "$SWAPPY_CONFIG_PATH")
  #   echo -e "$DEFAULT_SWAPPY_CONFIG\nsave_dir=$OUTPUT_FOLDER\nsave_filename_format=swappy-$SCREENSHOT_NAME" > $SWAPPY_CONFIG_PATH
  #   mkdir -p "$OUTPUT_FOLDER"
  #   print_error() {
  #   	cat <<"EOF"
  #       screenshot <action>
  #       ...valid actions are...
  #           screen - snip screen
  #           area - snip area
  #   EOF
  #   }
  #   case $1 in
  #   screen)
  #   	grimblast --freeze copysave screen $OUTPUT && swappy -f $OUTPUT ;;
  #   area)
  #   	grimblast --freeze copysave area $OUTPUT && swappy -f $OUTPUT ;;
  #   *)
  #   	print_error ;;
  #   esac
  #   if [ -f "${OUTPUT_FOLDER}${SCREENSHOT_NAME}" ]; then
  #   	notify-send -i "${OUTPUT_FOLDER}${SCREENSHOT_NAME}" "Saved screenshot in ${SCREENSHOT_FOLDER_NAME}${SCREENSHOT_NAME}"
  #   fi
  #   echo -e "$DEFAULT_SWAPPY_CONFIG" > $SWAPPY_CONFIG_PATH
  # '';
in {
  home.packages = with pkgs; [
    hyprcursor
    # xdg-desktop-portal-hyprland
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    # plugins = [
    #   inputs.hypr-dynamic-cursors.packages.${pkgs.system}.hypr-dynamic-cursors
    # ];
    settings = {
      "$mod" = "SUPER";
      "$terminal" = "kitty";
      "$fileManager" = "kitty yazi";
      "$menu" = "rofi -show drun";
      # "$wallpapers" = "~/.local/bin/swww-launch.sh";

      env = [
        "LIBVA_DRIVER_NAME,nvidia"
        "WLR_NO_HARDWARE_CURSORS,1"
      ];

      monitor = [
        "DP-1, 2560x1440@160Hz, 1080x0, 1"
        # "DP-2, 1920x1080@160Hz, 0x0, 1, transform, 1"
      ];

      exec-once = [
        # "~/.local/bin/swww-launch.sh"
        "[workspace 1 silent] kitty"
        "[workspace 1 silent] google-chrome-stable"
        "[workspace 2 silent] obsidian"
        "[workspace 3 silent] telegram-desktop"
        "swww-daemon &"
        "hypridle"
      ];

      # exec-once = "${startupScript}/bin/start";

      general = {
        gaps_in = 8;
        gaps_out = 16;

        border_size = 2;

        # "col.active_border" = "rgba(7287fdff)";
        # "col.inactive_border" = "rgba(595959aa)";

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
        kb_options = "grp:caps_toggle";

        follow_mouse = 0;
        sensitivity = -0.7;
        accel_profile = "flat";

        touchpad = {
          natural_scroll = true;
        };
      };

      device = {
        name = "compx-vgn-dragonfly-4k-receiver-consumer-control-1";
        sensitivity = -1.0;
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
        force_split = 2;
        split_width_multiplier = 1.5;
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_distance = 200;
      };

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };

      animations = {
        enabled = true;
        bezier = [
          "wind, 0.05, 0.9, 0.1, 1.05"
          "winIn, 0.1, 1.1, 0.1, 1.1"
          "winOut, 0.3, -0.3, 0, 1"
          "liner, 1, 1, 1, 1"
          "workIn, 0.72, -0.07, 0.41, 0.98"
        ];
        animation = [
          "windows, 1, 6, wind, slide"
          "windowsIn, 1, 6, winIn, slide"
          "windowsOut, 1, 5, winOut, slide"
          "windowsMove, 1, 5, wind, slide"
          "border, 1, 1, liner"
          "borderangle, 1, 30, liner, loop"
          "fade, 1, 10, default"
          "workspaces, 1, 5, wind"
          "specialWorkspace, 1, 5, workIn, slidevert"
        ];
      };

      decoration = {
        dim_special = 0.5;

        rounding = 10;

        shadow = {
          enabled = false;
          ignore_window = false;
          offset = "2 2";
          range = 20;
        };

        blur = {
          enabled = true;

          # size = 3;
          # passes = 1;
          # vibrancy = 0.1696;

          special = true;
          brightness = 1.0;
          contrast = 1.0;
          noise = 0.02;
          passes = 3;
          size = 10;
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
          "$mod, F, fullscreen"
          "$mod SHIFT, L, exec, hyprlock"

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

        "opacity 0.9 0.9, class:kitty"

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

      # extraConfig = ''
      #   plugins {
      #       dynamic-cursors {
      #       enabled = true
      #       mode = stretch
      #       threshhold = 1
      #       stretch {
      #           limit = 1500
      #           # linear, quadratic, negative_quadratic
      #           function = linear
      #       }
      #       shake {
      #           enabled = true
      #           # use nearest-neighbour (pixelated) scaling when shaking
      #           # may look weird when effects are enabled
      #           nearest = true
      #           # controls how soon a shake is detected
      #           # lower values mean sooner
      #           threshold = 5.0
      #           # magnification level immediately after shake start
      #           base = 4.0
      #           # magnification increase per second when continuing to shake
      #           speed = 5.0
      #           # how much the speed is influenced by the current shake intensitiy
      #           influence = 0.0
      #           # maximal magnification the cursor can reach
      #           # values below 1 disable the limit (e.g. 0)
      #           limit = 0.0
      #           # time in millseconds the cursor will stay magnified after a shake has ended
      #           timeout = 2000
      #           # show cursor behaviour `tilt`, `rotate`, etc. while shaking
      #           effects = false
      #           # enable ipc events for shake
      #           # see the `ipc` section below
      #           ipc = false
      #       }
      #       hyprcursor {
      #           enabled = true
      #       }
      #     }
      #   }
      # '';
    };
  };
}
