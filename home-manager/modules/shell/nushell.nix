{
  input,
  lib,
  config,
  pkgs,
  userSettings,
  ...
}:
let
  editorPkg = pkgs.${userSettings.editor};
  cfg = config.modules.nushell;
in
{
  options = {
    modules.nushell.enable = lib.mkEnableOption "nushell";
  };

  config = lib.mkIf cfg.enable {
    programs.nushell = {
      enable = true;

      # Corresponds to $env.config
      settings = {
        completions.algorithm = "fuzzy";
        highlight_resolved_externals = true;
        edit_mode = "vi";
        buffer_editor = lib.getExe editorPkg;
        # TODO: continue with keybindings and menus
      };

      # specific aliases for nushell only
      shellAliases = {
        fg = "job unfreeze";
        "job killall" = "do { job list | each { |j| job kill $j.id } }";
        cal = "cal --week-start mo";
      };
    };

  };
}
