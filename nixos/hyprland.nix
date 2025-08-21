{
  input,
  lib,
  config,
  pkgs,
  userSettings,
  ...
}:
let
  cfg = config.home-manager.users.${userSettings.username}.modules.hyprland;
in
{
  # Because home-manager option does not make certain system-level changes. We
  # must enable the Hyprland NixOS module, which makes system-level changes such
  # as adding a desktop session entry.
  programs.hyprland = lib.mkIf cfg.enable {
    enable = true;
    xwayland.enable = true;
  };
}
