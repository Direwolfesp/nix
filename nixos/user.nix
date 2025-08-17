{ pkgs, userSettings, ... }:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = pkgs.nushell;
    users.${userSettings.username} = {
        isNormalUser = true;
        description = userSettings.username;
        extraGroups = [ "networkmanager" "wheel" ];
    };
  };
}
