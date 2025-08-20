{
  input,
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.modules.mpv;
in
{
  options = {
    modules.mpv.enable = lib.mkEnableOption "mpv";
  };

  config = lib.mkIf cfg.enable {
    programs.mpv = {
      enable = true;

      scripts = [
        pkgs.mpvScripts.mpris
        pkgs.mpvScripts.modernz
        pkgs.mpvScripts.thumbfast
      ];
    };
  };
}
