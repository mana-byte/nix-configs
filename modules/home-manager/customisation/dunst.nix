{inputs, ...}: {
  flake.homeModules.dunstModule = {
    config,
    pkgs,
    ...
  }: {
    home.file.".config/dunst/scripts/brightness.sh" = {
      source = ../../dotfiles/dunst/brightness.sh;
      executable = true;
    };
    home.file.".config/dunst/scripts/volume.sh" = {
      source = ../../dotfiles/dunst/volume.sh;
      executable = true;
    };
    services.dunst = {
      enable = true;
      iconTheme.name = "Papirus-Dark";
      iconTheme.package = pkgs.catppuccin-papirus-folders;
      settings = {
        global = {
          width = "(0, 500)";
          height = "(0, 300)";
          origin = "bottom-right";
          font = "DepartureMono Nerd Font 12";
          offset = "(10, 10)";
          notification_limit = 10;
          gap_size = 5;
          frame_width = 2;
          show_age_threshold = 5;
          corner_radius = 5;
          corner = "all";
          browser = "brave";

          frame_color = "#b4befe"; # Catppuccin lavender mocha
        };

        urgency_low = {
          background = "#585b70"; # Catppuccin
          foreground = "#cdd6f4"; # Catppuccin
        };

        urgency_normal = {
          background = "#585b70"; # Catppuccin
          foreground = "#89b4fa"; # Catppuccin
        };

        urgency_critical = {
          background = "#585b70"; # Catppuccin
          foreground = "#f38ba8"; # Catppuccin saphire
        };
      };
    };
  };
}
