{
  pkgs,
  lib,
  userSettings,
  ...
}:
let
  useStylix = true;
in
{
  imports = [
    ./firefox.nix
    ./ghostty.nix
    ./git.nix
    ./gtk.nix
    ./helix.nix
    ./hypr # loads => ./hypr/default.nix
    ./jj.nix
    ./mpv.nix
    ./nixcord.nix
    ./qt.nix
    ./rofi # loads => ./rofi/default.nix
    ./shell # loads => ./shell/default.nix
    ./sioyek.nix
    ./waybar # loads => ./waybar/default.nix
    ./xdg.nix
    ./fastfetch_images.nix
  ];

  # NOTE: here we can enable/disable each application
  # indepently, maybe based on systemSettings.host

  # Gui Apps
  config.modules.firefox.enable = true;
  config.modules.mpv.enable = true;
  config.modules.nixcord.enable = true;
  config.modules.sioyek.enable = true;
  config.modules.ghostty.enable = true;

  # Cli
  config.modules.git.enable = true;
  config.modules.helix.enable = true;
  config.modules.jujutsu.enable = true;
  config.modules.xdg.enable = true;

  # WM and theming related
  config.modules.qt.enable = false;
  config.modules.gtk.enable = !useStylix;
  config.modules.waybar.enable = false;
  config.modules.rofi.enable = true;
}
