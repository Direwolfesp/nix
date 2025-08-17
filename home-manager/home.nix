{
  config,
  pkgs,
  systemSettings,
  userSettings,
  ...
}:
{
  imports = [
    ./modules
    ./home-packages.nix
  ];

  home = {
    username = userSettings.username;
    homeDirectory = "/home/${userSettings.username}";
    stateVersion = "25.05";
  };

  programs.home-manager.enable = true;
}
