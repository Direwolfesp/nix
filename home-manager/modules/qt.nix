{
  input,
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.modules.qt;
in
{
  options = {
    modules.qt.enable = lib.mkEnableOption "qt";
  };

  config = lib.mkIf cfg.enable {
    qt = {
      enable = false;

      # Change theme
      style = {
        package = pkgs.adwaita-qt;
        name = "adwaita-dark";
      };
    };
  };
}
