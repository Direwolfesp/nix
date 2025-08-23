{
  pkgs,
  lib,
  userSettings,
  ...
}:
{
  imports = [
    ./hyprland.nix
    ./dunst.nix
  ];

  # NOTE: here you can enable/disable each module independently
  # based on userSettings or systemSettings for example.
  config.modules.hyprland.enable = true;
  config.modules.dunst.enable = true;
}
