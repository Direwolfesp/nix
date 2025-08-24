{ pkgs, ... }:
let
  logoDir = "Pictures/fastfetch_logos";

  # Example image
  fubuki = pkgs.fetchurl {
    url = "https://pbs.twimg.com/media/GJDueQOXsAA7DjN?format=jpg&name=medium";
    hash = "sha256-m7175RBqjgsDb+yNyRkR0AnVp9rvG1nrX7HKpqSJLSU=";
  };

  # Add more here...
  geass = pkgs.fetchurl {
    url = "https://i.postimg.cc/FHrV4Y0d/geass.png";
    hash = "sha256-ijbt0aP+qj6uVbzl67uowzl85q0Wxg10sEKLaQym274=";
  };
in
{
  home.file = {
    "${logoDir}/Fubuki.jpg" = {
      source = fubuki;
    };

    "${logoDir}/geass.png" = {
      source = geass;
    };
  };
}
