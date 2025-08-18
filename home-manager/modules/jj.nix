{
  input,
  lib,
  config,
  pkgs,
  userSettings,
  ...
}:
let
  cfg = config.modules.jujutsu;
in
{
  options = {
    modules.jujutsu.enable = lib.mkEnableOption "jujutsu";
  };

  config = lib.mkIf cfg.enable {
    programs.jujutsu = {
      enable = true;

      settings = {
        ui.default-command = "log";

        user = {
          email = userSettings.email;
          name = userSettings.name;
        };
      };
    };

  };

}
