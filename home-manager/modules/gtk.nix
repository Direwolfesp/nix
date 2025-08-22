{
  input,
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.modules.gtk;
in
{
  options = {
    modules.gtk.enable = lib.mkEnableOption "gtk";
  };

  config = lib.mkIf cfg.enable {
    gtk = {
      enable = true;
    };
  };
}
