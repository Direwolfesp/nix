{
  input,
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.modules.yazi;
in
{
  options = {
    modules.yazi.enable = lib.mkEnableOption "yazi";
  };

  # ----------------------------------------------------------------#
  # Options: https://mynixos.com/home-manager/options/programs.yazi #
  # ----------------------------------------------------------------#
  config = lib.mkIf cfg.enable {
    programs.yazi = {
      enable = true;
      enableNushellIntegration = true;
      shellWrapperName = "y";

      plugins = {
        # See https://mynixos.com/nixpkgs/packages/yaziPlugins
      };
    };
  };
}
