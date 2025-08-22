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
    image = pkgs.fetchurl {
      url = bgUrl;
      hash = bgHash;
    };
    polarity = polarity;
  };
}
