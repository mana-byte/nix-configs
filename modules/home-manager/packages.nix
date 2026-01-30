{...}: {
  flake.homeModules.packages = {
    config,
    pkgs,
    ...
  }: {
    config.allowUnfree = true;

    programs.git = {
      enable = true;
      settings = {
        user = {
          name = "mana-byte";
          email = "manaikilaut@gmail.com";
        };
        init.defaultBranch = "main";
        pull.rebase = false;
        credential.helper = "store";
        color.ui = "auto";
      };
    };

    #GTK
    gtk = {
      enable = true;
      theme = {
        name = "catppuccin-frappe-blue-standard";
        package = pkgs.catppuccin-gtk;
        # package = pkgs.nwg-look;
      };
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.catppuccin-papirus-folders;
      };
      cursorTheme = {
        name = "Bibata-Modern-Classic";
        package = pkgs.bibata-cursors;
        size = 24;
      };
      font.name = "DepartureMono Nerd Font";
    };

    home.packages = with pkgs; [
      # system info : battery health, cpu temp, memory usage, disk usage, etc.
      inxi
      tldr

      #run software without installation requires nix index db in flake input
      comma

      # Matrix client
      element-desktop

      killall # kill all processes of a specific name

      # display management
      wdisplays

      # rasp pi
      rpi-imager

      # work basics
      neovim
      git
      gh
      kitty
      tmux
      nautilus
      clipman

      # apps
      rofi
      networkmanagerapplet

      # notifications
      dunst
      libnotify

      # nix packages
      alejandra
      nil
      # NIx prefetch scripts
      nix-prefetch-scripts
      # nixpkgs review
      nixpkgs-review

      # customisation
      starship
      neofetch
      sassc
      gtk-engine-murrine
      gnome-themes-extra
      rose-pine-hyprcursor
      swww
      pywal
      nwg-look

      # rofi applets dependencies: https://github.com/adi1090x/rofi?tab=readme-ov-file
      mpc

      # desktop software
      gimp
      discord
      imv
      # video playyer : also dependency for youtube tui
      mpv

      pavucontrol

      brave # web browser
      acpi # for battery status in hyprland bar
      cheese # for webcam

      obs-studio # screen recording and streaming

      # Useful TUI apps
      lazydocker
      # calcure # taskwarrior crashes
      s-tui
      htop

      # hyprland plugins
      hyprpolkitagent
      hyprshot
      hyprlock
      hypridle
      hyprcursor
      hyprsunset
      waybar

      # bluetooth interface
      adw-bluetooth

      # libreoffice
      libreoffice-fresh

      # coding cli
      mistral-vibe

      #TODO: remove test package
      cowsay
    ];
  };
}
