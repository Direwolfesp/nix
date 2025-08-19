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
        buffer_editor = # use the editor specified in flake.nix if possible
          if editorPkg ? meta.mainProgram then editorPkg.meta.mainProgram else userSettings.editor;

        # TODO: continue with keybindings and menus
      };

      shellAliases = {
        ll = "ls -l";
        zlj = "zellij";
        zbr = "zig build run";
        zrf = "zellij run -f --"; # zellij run in floating mode
        fg = "job unfreeze";
        "job killall" = "do { job list | each { |j| job kill $j.id } }";
        cal = "cal --week-start mo";
      };
    };

  };
}
