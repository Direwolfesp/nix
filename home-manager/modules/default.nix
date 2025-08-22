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
    ./ghostty.nix
    ./git.nix
    ./gtk.nix
    ./helix.nix
    ./hypr # loads => ./hypr/default.nix
    ./jj.nix
    ./mpv.nix
    ./nixcord.nix
    ./qt.nix
    ./shell # loads => ./shell/default.nix
    ./sioyek.nix
    ./xdg.nix
    ./firefox.nix
  ];

  # NOTE: here we can enable/disable each application
  # indepently, maybe based on systemSettings.host

  # Gui
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

  # Theme
  config.modules.qt.enable = !useStylix;
  config.modules.gtk.enable = !useStylix;

}
