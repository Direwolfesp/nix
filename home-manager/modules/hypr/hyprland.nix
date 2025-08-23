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
      pkgs.brightnessctl
      pkgs.grim
      pkgs.hyprpicker
      pkgs.slurp
      pkgs.wl-clipboard
    ];

    wayland.windowManager.hyprland = {
      enable = true;

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
          # kb_layout = "es";

          accel_profiles = "flat";
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
        gestures = {
          workspace_swipe = true;
        };

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
            enable = true;
            size = 6;
            passes = 2;
            new_optimizations = "on";
            ignore_opacity = true;
          };
        };

        # Groups
        group.groupbar.enable = true;

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

        # Windowrules
        windowrule = [
          # Pavucontrol floating
          "float,        class:(.*org.pulseaudio.pavucontrol.*)"
          "size 700 600, class:(.*org.pulseaudio.pavucontrol.*)"
          "center,       class:(.*org.pulseaudio.pavucontrol.*)"

          # Waypaper floating
          "float,        class:(.*waypaper.*)"
          "size 800 700, class:(.*waypaper.*)"
          "center,       class:(.*waypaper.*)"

          # float and resize emote picker
          "float,        initialclass:^(it.mijorus.smile)$"
          "size 805 500, initialclass:^(it.mijorus.smile)$"

          # fixes for focusing browser
          "focusonactivate,  initialclass:firefox"
          "syncfullscreen 0, initialclass:firefox"
        ];

        # Keybindings
        # TODO: acabar los putos keybiiinds
        bind = lib.flatten [
          # Workspaces
          (
            lib.map (n: [
              "SUPER      , ${toString n}, workspace            , ${toString n}"
              "SUPER+SHIFT, ${toString n}, movetoworkspacesilent, ${toString n}"
            ])
            <| lib.range 1 9
          )

          # ...
        ];

      };
    };
  };
}
