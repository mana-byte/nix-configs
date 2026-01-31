{inputs, ...}: {
  flake.homeModules.packages = {
    config,
    pkgs,
    ...
  }: {
    nixpkgs.config.allowUnfree = true;

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
      gh
      kitty
      tmux
      nautilus
      clipman

      # apps
      rofi
      networkmanagerapplet

      # notifications
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
    ];
  };
}
