{
  pkgs,
  lib,
  userSettings,
  ...
}:
{
  imports = [
    ./hyprland.nix
  ];

  # NOTE: here you can enable/disable each module independently
  # based on userSettings or systemSettings for example.
  config.modules.hyprland.enable = false;
}
