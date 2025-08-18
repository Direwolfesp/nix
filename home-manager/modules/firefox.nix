{
  input,
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.modules.firefox;
in
{
  options = {
    modules.firefox.enable = lib.mkEnableOption "firefox";
  };

  config = lib.mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      # TODO: add more config
    };

  };
}
