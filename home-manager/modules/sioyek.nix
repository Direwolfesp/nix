{
  input,
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.modules.sioyek;
in
{
  options = {
    modules.sioyek.enable = lib.mkEnableOption "sioyek";
  };

  config = lib.mkIf cfg.enable {
    programs.sioyek = {
      enable = true;
      bindings = {
        "next_page" = "J";
        "previous_page" = "K";
      };
    };
  };
}
