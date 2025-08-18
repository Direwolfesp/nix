{ pkgs, userSettings, ... }:
let
  usr = userSettings;
  shellPkg =
    if pkgs ? "${usr.shell}" then
      pkgs.${usr.shell}
    else
      throw "Provided shell '${usr.shell}' not found in pkgs";
in
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${usr.username} = {
    shell = shellPkg;
    isNormalUser = true;
    description = usr.username;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
}
