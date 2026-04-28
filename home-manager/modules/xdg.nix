{
  input,
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.modules.xdg;

  # Default apps .desktop (user packages are in /etc/profiles/per-user/<user>/share/applications)
  # TODO: synchronize it with userSettings
  browser = "firefox.desktop";
  editor = "Helix.desktop";
  video = "mpv.desktop";
  graphic = "sioyek.desktop";

  # for XDG_DIRS
  homeDir = config.home.homeDirectory;
in
{
  options = {
    modules.xdg.enable = lib.mkEnableOption "xdg";
  };

  config = lib.mkIf cfg.enable {
    xdg = {
      enable = true;

      # XDG data directories
      cacheHome = "${homeDir}/.cache";
      configHome = "${homeDir}/.config";
      dataHome = "${homeDir}/.local/share";
      stateHome = "${homeDir}/.local/state";

      # XDG user directories
      userDirs = {
        desktop = "${homeDir}/Desktop";
        documents = "${homeDir}/Documents";
        download = "${homeDir}/Downloads";
        music = "${homeDir}/Music";
        pictures = "${homeDir}/Pictures";
        publicShare = "${homeDir}/Public";
        templates = "${homeDir}/Templates";
        videos = "${homeDir}/Videos";
        projects = "${homeDir}/Projects";
      };

      # xdg desktop portal
      portal = {
        enable = true;
        extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
      };

      # manages mimeapps.list
      mimeApps = {
        enable = true;

        defaultApplications = {
          # web
          "text/html" = browser;
          "x-scheme-handler/http" = browser;
          "x-scheme-handler/https" = browser;
          "x-scheme-handler/about" = browser;
          "x-scheme-handler/unknown" = browser;

          # text
          "application/json" = editor;
          "application/schema+json" = editor;
          "application/toml" = editor;
          "application/vnd.apple.keynote" = editor;
          "application/x-bittorrent" = editor;

          # video
          "video/mp4" = video;
          "video/x-matroska" = video;
          "image/gif" = video;

          # images
          "application/pdf" = graphic;
          "image/jpeg" = graphic;
          "image/png" = graphic;
        };
      };
    };
  };
}
