{ userSettings, ... }:
{
  programs.jujutsu = {
    enable = true;

    settings = {
      ui.default-command = "log";

      user = {
        email = userSettings.email;
        name = userSettings.name;
      };
    };
  };
}
