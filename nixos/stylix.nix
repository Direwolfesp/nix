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

    fonts = {
      monospace = {
        name = userSettings.font;
        package = userSettings.fontPkg;
      };

      serif = {
        name = userSettings.font;
        package = userSettings.fontPkg;
      };

      sansSerif = {
        name = userSettings.font;
        package = userSettings.fontPkg;
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
