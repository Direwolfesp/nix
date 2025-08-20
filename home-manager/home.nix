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

    # common aliases across shells
    shellAliases = {
      zrf = "zellij run -f --"; # zellij run in floating mode
      zbr = "zig build run";
      zlj = "zellij";
      ll = "ls -l";
      cd = "z";
      ".." = "cd ..";
    };
  };

  programs.home-manager.enable = true;
}
