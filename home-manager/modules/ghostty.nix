{
  input,
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.modules.ghostty;
in
{
  options = {
    modules.ghostty.enable = lib.mkEnableOption "ghostty";
  };

  config = lib.mkIf cfg.enable {
    stylix.targets.ghostty.enable = false;
    programs.ghostty = {
      enable = true;
      settings = {
        # font-family = "JetBrainsMono NerdFont";
        theme = "Citruszest";
        app-notifications = "no-clipboard-copy";
        background-opacity = 0.9;
        confirm-close-surface = "false";
        custom-shader-animation = "always";
        font-size = 15;
        foreground = "ffffff";
        gtk-single-instance = "false";
        gtk-tabs-location = "hidden";
        window-decoration = "none";
        window-theme = "ghostty";

        keybind = [
          # close splits
          "ctrl+shift+w=close_surface"
          "ctrl+shift+q=close_surface"

          # Move between splits
          "ctrl+shift+k=goto_split:up"
          "ctrl+shift+j=goto_split:down"
          "ctrl+shift+h=goto_split:left"
          "ctrl+shift+l=goto_split:right"
        ];
      };
    };
  };
}
