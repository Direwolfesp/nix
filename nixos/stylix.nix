{
  inputs,
  lib,
  config,
  pkgs,
  userSettings,
  ...
}:
let
  themeDir = "${inputs.self.outPath}/themes/${userSettings.theme}";
  theme = "${themeDir}/${userSettings.theme}.yaml";
  polarity = lib.removeSuffix "\n" (builtins.readFile ("${themeDir}/polarity.txt"));
  bgUrl = builtins.readFile ("${themeDir}/background.txt");
  bgHash = builtins.readFile ("${themeDir}/background-sha256.txt");
in
{
  stylix = {
    enable = true;
    base16Scheme = theme;
    polarity = polarity;

    image = pkgs.fetchurl {
      url = bgUrl;
      hash = bgHash;
    };

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };

    fonts = {
      monospace = {
        name = userSettings.font;
        package = userSettings.fontPkg;
      };

      serif = {
        package = pkgs.nerd-fonts.noto;
        name = "Noto Serif Nerd Font";
      };

      sansSerif = {
        package = pkgs.nerd-fonts.noto;
        name = "Noto Sans Nerd Font";
      };

      emoji = {
        name = "Noto Emoji";
        package = pkgs.noto-fonts-monochrome-emoji;
      };

      sizes = {
        terminal = 18;
        applications = 12;
        popups = 12;
        desktop = 12;
      };
    };
  };
}
