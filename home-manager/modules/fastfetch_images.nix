{ pkgs, ... }:
let
  logoDir = "Pictures/fastfetch_logos";

  # Example image
  geass = pkgs.fetchurl {
    url = "https://i.postimg.cc/FHrV4Y0d/geass.png";
    hash = "sha256-ijbt0aP+qj6uVbzl67uowzl85q0Wxg10sEKLaQym274=";
  };

  chariot = pkgs.fetchurl {
    url = "https://w7.pngwing.com/pngs/279/963/png-transparent-jojo-s-bizarre-adventure-eyes-of-heaven-jojo-s-bizarre-adventure-all-star-battle-josuke-higashikata-silver-chariot-others.png";
    hash = "sha256-7rfbCFhM+yU7dfLcponJsFQarK/xJge7FcpoNOVWPgQ=";
  };

  # Add more here...
in
{
  home.file = {
    "${logoDir}/geass.png" = {
      source = geass;
    };

    "${logoDir}/chariot.png" = {
      source = chariot;
    };
  };
}
