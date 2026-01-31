{inputs, ...}: {
  flake.nixosModules.basicPackages = {
    config,
    pkgs,
    ...
  }: {
    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
      # linux firmware
      linux-firmware
      # cachix to avoid compiling everything
      cachix
      # list of open files
      lsof
      # basic editor
      vim
      # d bus service
      xdg-desktop-portal
      # usb automount not movable to home manager
      udiskie
      usbutils
      udisks

      #power management
      lm_sensors
      brightnessctl

      # terminal emulator
      kitty

      # disk management
      gparted

      # mixer
      pamixer
    ];
  };
}
