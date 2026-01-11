{
  input,
  lib,
  config,
  systemSettings,
  pkgs,
  ...
}:
let
  cfg = config.modules.hyprland;
in
{
  options = {
    modules.hyprland.enable = lib.mkEnableOption "hyprland";
  };

  config = lib.mkIf cfg.enable {
    # Extra packages for hyprland
    home.packages = with pkgs; [
      brightnessctl
      grim
      grimblast
      hyprpicker
      hyprpaper
      hyprlock
      hypridle
      hyprls
      hyprshot
      slurp
      wlogout
      wl-clipboard
      tesseract
      waypaper
    ];

    stylix.targets.hyprland.hyprpaper.enable = true;
    stylix.targets.hyprlock.enable = true;
    stylix.targets.zed.enable = true;
    stylix.targets.firefox.enable = true;

    # Disable these
    stylix.targets.rofi.enable = false;
    stylix.targets.dunst.enable = false;
    stylix.targets.waybar.enable = false;

    # Some important services
    services.cliphist.enable = true;
    services.cliphist.allowImages = true;

    wayland.windowManager.hyprland = {
      enable = true;

      systemd.variables = [ "--all" ];

      settings = {
        # Monitor config based on host
        monitor =
          if systemSettings.host == "Laptop" then
            [
              ", preferred, auto, 1"
            ]
          else if systemSettings.host == "Desktop" then
            [
              "HDMI-A-3, highres highrr, 1920x0, 1"
              "DP-3,     highres highrr, 0x0,    1"
            ]
          else
            throw "Unsupported host '${systemSettings.host}'";

        # Keyboard Layout
        input = {
          # I hope this kb settings are already
          # managed by configuration.nix
          kb_layout = "es";
          kb_options = "caps:swapescape";

          accel_profile = "flat";
          follow_mouse = 1;
          float_switch_override_focus = 0;
          sensitivity = 0;

          # Touchpad
          touchpad =
            if systemSettings.host == "Desktop" then
              {
                natural_scroll = false;
              }
            else if systemSettings.host == "Laptop" then
              {
                natural_scroll = true;
                clickfinger_behavior = true;
                drag_lock = true;
                scroll_factor = 0.7;
              }
            else
              throw "Unsupported host '${systemSettings.host}'";

          repeat_delay = 400;
          repeat_rate = 100;
        };

        # Gestures
        gesture = [ "3, horizontal, workspace" ];

        # General window layouts and colors
        general = {
          gaps_in = 7;
          gaps_out = 14;
          border_size = 2;
          layout = "dwindle";
          resize_on_border = true;
        };

        # General window decoration
        decoration = {
          rounding = 10;
          active_opacity = 1.0;
          inactive_opacity = 0.8;
          fullscreen_opacity = 1.0;

          blur = {
            enabled = true;
            size = 6;
            passes = 2;
            new_optimizations = "on";
            ignore_opacity = true;
          };
        };

        # Animations
        animations = {
          # disable them in Laptop only
          enabled = if systemSettings.host == "Laptop" then false else true;

          # Animation curves
          bezier = [
            "linear,            0,     0,     1,     1"
            "md3_standard,    0.2,     0,     0,     1"
            "md3_decel,      0.05,   0.7,   0.1,     1"
            "md3_accel,       0.3,     0,   0.8,  0.15"
            "overshot,       0.05,   0.9,   0.1,   1.1"
            "crazyshot,       0.1,   1.5,  0.76,  0.92"
            "hyprnostretch,  0.05,   0.9,   0.1,   1.0"
            "menu_decel,      0.1,     1,     0,     1"
            "menu_accel,     0.38,  0.04,     1,  0.07"
            "easeInOutCirc,  0.85,     0,  0.15,     1"
            "easeOutCirc,       0,  0.55,  0.45,     1"
            "easeOutExpo,    0.16,     1,   0.3,     1"
            "softAcDecel,    0.26,  0.26,  0.15,     1"
            "md2,             0.4,     0,   0.2,     1" # use with .2s duration
          ];

          # Animation configs
          animation = [
            "windows,            1,   3, md3_decel, popin 60%"
            "windowsIn,          1,   3, md3_decel, popin 60%"
            "windowsOut,         1,   3, md3_accel, popin 60%"
            "border,             1,  10, default"
            "fade,               1,   3, md3_decel"
            # "layers,           1,   2, md3_decel, slide"
            "layersIn,           1,   3, menu_decel, slide"
            "layersOut,          1, 1.6, menu_accel"
            "fadeLayersIn,       1,   2, menu_decel"
            "fadeLayersOut,      1, 4.5, menu_accel"
            # "workspaces,       1,   7, menu_decel, slide"
            "workspaces,         1, 2.5, softAcDecel, slide"
            # "workspaces,       1,   7, menu_decel, slidefade 15%"
            # "specialWorkspace, 1,   3, md3_decel, slidefadevert 15%"
            "specialWorkspace,   1,   3, md3_decel, slidevert"
          ];
        };

        # Groups
        group.groupbar.enabled = true;

        # Layouts
        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };

        # Misc
        misc = {
          disable_hyprland_logo = true;
          disable_splash_rendering = true;

          vrr = 1;
          initial_workspace_tracking = 2;
          animate_manual_resizes = true;

          # swallow
          enable_swallow = true;
          swallow_regex = "^(com.mitchellh.ghostty|Alacritty)";

          key_press_enables_dpms = true;
          mouse_move_enables_dpms = true;
        };

        cursor = {
          hide_on_key_press = true;
        };

        # Windowrules
        windowrule = [
          # Pavucontrol floating
          "float on, size 700 600, center on, match:class (.*org.pulseaudio.pavucontrol.*)"
          # Waypaper floating
          "float on, size 700 600, center on, match:class (.*waypaper.*)"
          # float and resize emote picker
          "float on, size 700 600, center on, match:initial_class ^(it.mijorus.smile)$"
          # fixes for focusing browser
          "focus_on_activate on, match:initial_class firefox"
        ];

        # Important services at startup
        exec-once = [
          "waybar"
          "hyprpaper"
          "dunst"
          "wl-paste --watch cliphist store"
          "systemctl --user start hyprpolkitagent"
          "hypridle"
        ];

        # Keybindings
        bind = lib.flatten [
          # Workspaces
          (
            lib.map (n: [
              "SUPER      , ${toString n}, workspace            , ${toString n}"
              "SUPER+SHIFT, ${toString n}, movetoworkspacesilent, ${toString n}"
            ])
            <| lib.range 1 9
          )
          "Alt-L, Tab, swapactiveworkspaces, 0 1" # Swap workspaces
          "SUPER, Q,   killactive" # Kill active window
          "SUPER, F,   fullscreen, 2" # Set active window to fullscreen
          "SUPER, T,   togglefloating" # Toggle active windows into floating mode
          "SUPER, I,   togglesplit" # Toggle split

          "SUPER, G, togglegroup" # Toggle window group
          "Alt_L, l, changegroupactive, f" # changes window forward inside a group
          "Alt_L, h, changegroupactive, b" # changes window backward inside a group

          # Focus windows
          "SUPER, h, movefocus, l" # Move focus left
          "SUPER, l, movefocus, r" # Move focus right
          "SUPER, k, movefocus, u" # Move focus up
          "SUPER, j, movefocus, d" # Move focus down

          # Move windows
          "SUPER CTRL, h, swapwindow, l"
          "SUPER CTRL, j, movewindow, d"
          "SUPER CTRL, k, movewindow, u"
          "SUPER CTRL, l, swapwindow, r"

          # Personal apps
          "SUPER,      RETURN,  exec, ghostty" # Open the terminal
          "SUPER CTRL, RETURN , exec, ghostty" # Open secondary terminal
          "SUPER,      w,       exec, firefox" # Open webbroser
          "SUPER,      E,       exec, ghostty -e yazi" # Open file browser

          "SUPER,       m,   exec, jellyfinmediaplayer" # m media
          "SUPER SHIFT, m,   exec, pear-desktop" # M music
          "SUPER,       d,   exec, discord" # d discord
          "SUPER SHIFT, e,   exec, ghostty -e yazi" # opens yazi
          "SUPER,       c,   exec, zeditor" # C editor
          "SUPER CTRL,  e,   exec, smile " # emoji picker
          "SUPER,       o,   exec, rofi -show calc -modi calc -no-show-mati -no-sort" # calculator

          # Fullscreen
          "SUPER SHIFT, f,   fullscreen, 1" # fullscreen with borders
          "SUPER CTRL,  f,   fullscreenstate, 2 0" # internal fullscreen state
          "SUPER,       tab, togglespecialworkspace" # special workspace
          "SUPER,       z,   movetoworkspace, special" # moves to hidden

          # Actions
          "SUPER CTRL,  Q,     exec, wlogout" # Start wlogout
          "SUPER SHIFT, W,     exec, waypaper --random" # Change the wallpaper
          "SUPER CTRL,  W,     exec, waypaper" # Open wallpaper selector
          "SUPER,       SPACE, exec, rofi -show drun -replace -i -terminal ghostty" # Open application launcher
          "SUPER SHIFT, space, exec, rofi -show run -terminal ghostty" # same but run mode
          "SUPER,       V,     exec, sh -c 'cliphist list | rofi -dmenu -replace | cliphist decode | wl-copy'"
          "SUPER SHIFT, b,     exec, pkill waybar; waybar" # reloads waybar
        ];

        bindm = [
          "SUPER, mouse:272, movewindow" # Move window with the mouse
          "SUPER, mouse:273, resizewindow" # Resize window with the mouse
        ];

        bindl = [
          # Fn keys
          ", XF86MonBrightnessUp,   exec, brightnessctl -q s +10%" # Increase brightness by 10%
          ", XF86MonBrightnessDown, exec, brightnessctl -q s 10%-" # Reduce brightness by 10%
          ", XF86AudioMute,         exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle" # Toggle mute
          ", XF86AudioPlay,         exec, playerctl play-pause" # Audio play pause
          ", XF86AudioPause,        exec, playerctl pause" # Audio pause
          ", XF86AudioNext,         exec, playerctl next" # Audio next
          ", XF86AudioPrev,         exec, playerctl previous" # Audio previous
          ", XF86AudioMicMute,      exec, pactl set-source-mute @DEFAULT_SOURCE@ toggle" # Toggle microphone
          ", XF86Calculator,        exec, qalculate-gtk" # Open calculator
          ", XF86Lock,              exec, hyprlock" # Open screenlock
        ];

        binde = [
          # Fn keys
          ", XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%" # Increase volume by 5%
          ", XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%" # Reduce volume by 5%

          # Resize with keyboard
          "SUPER SHIFT, l, resizeactive, 40 0" # Increase window width
          "SUPER SHIFT, h, resizeactive, -40 0" # Reduce window width
          "SUPER SHIFT, j, resizeactive, 0 40" # Increase window height
          "SUPER SHIFT, k, resizeactive, 0 -40" # Reduce window height
        ];
      };
    };
  };
}
