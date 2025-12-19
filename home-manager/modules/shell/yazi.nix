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
      enableBashIntegration = true;
      shellWrapperName = "y";

      # open a video in mpv forcing kitty protocol, useful for previews ssh
      keymap.mgr.prepend_keymap = [
        {
          on = [
            "O"
            "v"
          ];
          run = "shell 'mpv --vo=kitty $@' --block";
          desc = "Open selected files in MPV using kitty graphics protocol";
        }
      ];

      plugins = {
        # See https://mynixos.com/nixpkgs/packages/yaziPlugins
      };
    };
  };
}
