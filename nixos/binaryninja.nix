{ pkgs, ... }:
{
  programs.binary-ninja = {
    enable = false;
    package = pkgs.binary-ninja-free-wayland;
  };
}
