{
  pkgs,
  lib,
  userSettings,
  ...
}:
{
  imports = [
    ./firefox.nix
    ./ghostty.nix
    ./git.nix
    ./helix.nix
    ./jj.nix
    ./nixcord.nix
    ./sioyek.nix
    ./shell # loads => ./shell/default.nix
    ./xdg-mime.nix
    ./mpv.nix
  ];

  # NOTE: here we can enable/disable each application
  # indepently, maybe based on systemSettings.host
  config.modules.firefox.enable = true;
  config.modules.ghostty.enable = true;
  config.modules.git.enable = true;
  config.modules.helix.enable = true;
  config.modules.jujutsu.enable = true;
  config.modules.nixcord.enable = true;
  config.modules.sioyek.enable = true;
  config.modules.xdg-mime.enable = true;
  config.modules.mpv.enable = true;
}
