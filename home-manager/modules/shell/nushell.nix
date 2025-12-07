{
  input,
  lib,
  config,
  pkgs,
  userSettings,
  ...
}:
let
  cfg = config.modules.nushell;

  editorPkg =
    if pkgs ? "${userSettings.editor}" then
      pkgs.${userSettings.editor}
    else
      throw "Provided editor '${userSettings.editor}' not found in nixpkgs.";
in
{
  options = {
    modules.nushell.enable = lib.mkEnableOption "nushell";
  };

  config = lib.mkIf cfg.enable {
    stylix.targets.nushell.enable = false;

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

      # specific aliases for nushell
      shellAliases = {
        fg = "job unfreeze";
        "job killall" = "do { job list | each { |j| job kill $j.id } }";
        cal = "cal --week-start mo";

        # used to create nix SRI hashes for resources
        get_nix_hash = ''
          do { |url|
            nix store prefetch-file --hash-type sha256 --json $url | from json | get hash
          }'';
      };
    };

  };
}
