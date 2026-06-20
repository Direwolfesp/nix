{
  input,
  lib,
  config,
  pkgs,
  userSettings,
  ...
}:
let
  cfg = config.modules.git;
in
{
  options = {
    modules.git.enable = lib.mkEnableOption "git";
  };

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;

      settings = {
        user = {
          name = userSettings.name;
          email = userSettings.email;
        };
      };

    };
  };
}
