{
  input,
  lib,
  config,
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
    wayland.windowManager.hyprland = {
      enable = true;
    };
  };
}
