{
  input,
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.modules.btop;
in
{
  options = {
    modules.btop.enable = lib.mkEnableOption "btop";
  };

  config = lib.mkIf cfg.enable {
    programs.btop = {
      enable = true;
    };
  };
}
