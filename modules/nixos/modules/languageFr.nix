{inputs, ...}: {
  flake.nixosModules.languageFr = {
    config,
    pkgs,
    ...
  }: {
    # Set your time zone.
    time.timeZone = "Europe/Paris";
    # services.automatic-timezoned.enable = true;

    # Configure console keymap
    console.keyMap = "fr";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_NZ.UTF-8";
    i18n.extraLocales = ["fr_FR.UTF-8/UTF-8"];
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_NZ.UTF-8";
      LC_IDENTIFICATION = "en_NZ.UTF-8";
      LC_MEASUREMENT = "en_NZ.UTF-8";
      LC_MONETARY = "en_NZ.UTF-8";
      LC_NAME = "en_NZ.UTF-8";
      LC_NUMERIC = "en_NZ.UTF-8";
      LC_PAPER = "en_NZ.UTF-8";
      LC_TELEPHONE = "en_NZ.UTF-8";
      LC_TIME = "en_NZ.UTF-8";
    };

    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "fr";
      variant = "azerty";
    };
  };
}
