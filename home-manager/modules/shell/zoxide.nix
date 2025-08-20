{
  input,
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.modules.zoxide;
in
{
  options = {
    modules.zoxide.enable = lib.mkEnableOption "zoxide";
  };

  config = lib.mkIf cfg.enable {
    programs.zoxide = {
      enable = true;
      enableNushellIntegration = true;
      enableBashIntegration = true;
    };
  };
}
