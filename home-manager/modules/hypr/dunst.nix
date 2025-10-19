{
  input,
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.modules.dunst;
in
{
  options = {
    modules.dunst.enable = lib.mkEnableOption "dunst";
  };

  config = lib.mkIf cfg.enable {
    services.dunst = {
      enable = true;
      settings = {
        global = {
          font = "JetBrainsMono Nerd Font 10";
          frame_color = "#82aaff";
          separator_color = "frame";
          padding = 16;
          horizontal_padding = 16;
          frame_width = 2;
          corner_radius = 12;
          background = "#1e1e2e";
          foreground = "#cdd6f4";
          transparency = 10;
          icon_position = "left";
          markup = "full";
        };

        urgency_low = {
          background = "#1e1e2e";
          foreground = "#a6adc8";
          timeout = 5;
        };

        urgency_normal = {
          background = "#1e1e2e";
          foreground = "#cdd6f4";
          timeout = 7;
        };

        urgency_critical = {
          background = "#f38ba8";
          foreground = "#1e1e2e";
          timeout = 0;
        };
      };
    };
  };
}
