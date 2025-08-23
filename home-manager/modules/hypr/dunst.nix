{
  input,
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.modules.dunst;
in
{
  options = {
    modules.dunst.enable = lib.mkEnableOption "dunst";
  };

  config = lib.mkIf cfg.enable {
    services.dunst = {
      enable = true;
    };
  };
}
