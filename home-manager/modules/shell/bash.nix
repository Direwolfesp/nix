{
  input,
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.modules.bash;
in
{
  options = {
    modules.bash.enable = lib.mkEnableOption "bash";
  };

  config = lib.mkIf cfg.enable {
    programs.bash = {
      enable = true;
    };
  };
}
