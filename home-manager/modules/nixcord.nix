{
  input,
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.modules.nixcord;
in
{
  options = {
    modules.nixcord.enable = lib.mkEnableOption "nixcord";
  };

  #-------------------------------------------------#
  # Docs here: https://flameflag.github.io/nixcord/ #
  #-------------------------------------------------#
  config = lib.mkIf cfg.enable {
    programs.nixcord = {
      # enables discord with vencord
      enable = true;

      discord = {
        # oneof {“stable”, “ptb”, “canary”, “development”}
        branch = "stable";
      };

      config = {
        # use out quickCSS
        useQuickCss = true;

        # or use an online theme (for now, let stylix handle it)
        themeLinks = [
          "https://refact0r.github.io/midnight-discord/build/midnight.css"
        ];

        # Vencord plugins
        plugins = {
          fakeNitro.enable = true;
          biggerStreamPreview.enable = true;
          webKeybinds.enable = true;
          youtubeAdblock.enable = true;
          quickReply.enable = true;
          volumeBooster.enable = true;
        };
      };
    };
  };
}
