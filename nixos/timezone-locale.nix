{systemSettings, ...}:
{
  # Timezone and locales
  time.timeZone = systemSettings.timezone;
  i18n.defaultLocale = systemSettings.defaultLocale;
  i18n.extraLocaleSettings = {
    LC_ADDRESS = systemSettings.defaultLocale;
    LC_IDENTIFICATION = systemSettings.defaultLocale;
    LC_MEASUREMENT = systemSettings.defaultLocale;
    LC_MONETARY = systemSettings.defaultLocale;
    LC_NAME = systemSettings.defaultLocale;
    LC_NUMERIC = systemSettings.defaultLocale;
    LC_PAPER = systemSettings.defaultLocale;
    LC_TELEPHONE = systemSettings.defaultLocale;
    LC_TIME = systemSettings.defaultLocale;
  };
}
