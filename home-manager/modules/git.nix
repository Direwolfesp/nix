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
      userName = userSettings.name;
      userEmail = userSettings.email;
    };
  };
}
