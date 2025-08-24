{
  config,
  pkgs,
  lib,
  systemSettings,
  userSettings,
  ...
}:
{
  imports = [
    ./modules # loads => ./modules/default.nix
    ./home-packages.nix
  ];

  home = {
    username = userSettings.username;
    homeDirectory = "/home/${userSettings.username}";
    stateVersion = "25.05"; # dont touch

    # common aliases across shells
    shellAliases = {
      zrf = "zellij run -f --"; # zellij run in floating mode
      zbr = "zig build run";
      zlj = "zellij";
      ll = "ls -l";
      cd = "z";
      ".." = "cd ..";
      "tree" = "eza --tree";
    };

    # Environment variables to always set at login.
    sessionVariables =
      let
        editorPkg =
          if pkgs ? "${userSettings.editor}" then
            pkgs.${userSettings.editor}
          else
            throw "Provided editor '${userSettings.editor}' not found in nixpkgs.";
      in
      {
        EDITOR = lib.getExe editorPkg;
        VISUAL = lib.getExe editorPkg;
        TERMINAL = lib.getExe pkgs.ghostty;
        NIXOS_OZONE_WL = "1"; # Enables wayland support in nixpkgs
      };
  };

  programs.home-manager.enable = true;
}
