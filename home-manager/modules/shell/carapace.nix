{
  input,
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.modules.carapace;
in
{
  options = {
    modules.carapace.enable = lib.mkEnableOption "carapace";
  };

  config = lib.mkIf cfg.enable {
    programs.carapace = {
      enable = true;
      enableNushellIntegration = true;
      enableBashIntegration = true;
    };
  };
}
