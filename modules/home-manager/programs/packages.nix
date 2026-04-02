{ inputs, ... }:
{
  flake.homeModules.desktopPackages =
    {
      config,
      pkgs,
      ...
    }:
    {
      nixpkgs.config.allowUnfree = true;

      home.packages = with pkgs; [

        # Matrix client
        element-desktop

        # display management
        wdisplays

        # rasp pi
        rpi-imager

        # apps
        rofi
        networkmanagerapplet

        # customisation
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
        nautilus
        discord
        imv
        # video playyer : also dependency for youtube tui
        mpv

        pavucontrol

        brave # web browser
        acpi # for battery status in hyprland bar
        cheese # for webcam

        obs-studio # screen recording and streaming

        # calcure # taskwarrior crashes
        s-tui
        htop

        # libreoffice
        libreoffice-fresh
      ];
    };
}
