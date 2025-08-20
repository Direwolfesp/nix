{
  pkgs,
  lib,
  userSettings,
  ...
}:
{
  # Modules related to the shell,
  # they are highly integrated with nushell.
  imports = [
    ./carapace.nix
    ./nushell.nix
    ./starship.nix
    ./yazi.nix
    ./zoxide.nix
    ./bash.nix
  ];

  config.modules.carapace.enable = true;
  config.modules.nushell.enable = true;
  config.modules.starship.enable = true;
  config.modules.yazi.enable = true;
  config.modules.zoxide.enable = true;
  config.modules.bash.enable = true;
}
