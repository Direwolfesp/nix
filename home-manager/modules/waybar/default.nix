{
  input,
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.modules.waybar;
in
{
  imports = [
    ./config.nix
    ./style.nix
  ];

  options = {
    modules.waybar.enable = lib.mkEnableOption "waybar";
  };

  config = lib.mkIf cfg.enable {
    programs.waybar = {
      enable = true;
      systemd.enable = true;
    };
  };
}
