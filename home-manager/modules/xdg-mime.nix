{
  input,
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.modules.xdg-mime;
  # Change the .desktop files to your like.
  # (user packages are in /etc/profiles/per-user/<user>/share/applications)
  browser = "firefox.desktop";
  editor = "Helix.desktop";
  video = "mpv.desktop";
  graphic = "sioyek.desktop";
in
{
  options = {
    modules.xdg-mime.enable = lib.mkEnableOption "xdg-mime";
  };

  config = lib.mkIf cfg.enable {
    xdg.mimeApps = {
      # manages mimeapps.list
      enable = true;

      defaultApplications = {
        "text/html" = browser;
        "x-scheme-handler/http" = browser;
        "x-scheme-handler/https" = browser;
        "x-scheme-handler/about" = browser;
        "x-scheme-handler/unknown" = browser;

        "application/json" = editor;
        "application/schema+json" = editor;
        "application/toml" = editor;
        "application/vnd.apple.keynote" = editor;
        "application/x-bittorrent" = editor;

        "video/mp4" = video;
        "video/x-matroska" = video;
        "image/gif" = video;

        "application/pdf" = graphic;
        "image/jpeg" = graphic;
        "image/png" = graphic;
      };
    };
  };
}
