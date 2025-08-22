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
    programs.ghostty = {
      enable = true;
      settings = {
        # font-family = "JetBrainsMono NerdFont";
        # theme = "citruszest";
        custom-shader-animation = "always";
        window-decoration = "none";
        window-theme = "ghostty";
        background-opacity = 0.8;
        font-size = 15;
        gtk-tabs-location = "hidden";
        confirm-close-surface = "false";
        app-notifications = "no-clipboard-copy";

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
