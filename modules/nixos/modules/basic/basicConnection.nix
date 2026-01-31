{inputs, ...}: {
  flake.nixosModules.basicConnection = {
    config,
    pkgs,
    ...
  }: {
    networking.hostName = "nixos"; # Define your hostname.

    # Enable networking
    networking.networkmanager.enable = true;

    hardware.bluetooth.enable = true; # enables support for Bluetooth
    hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
    # services.blueman.enable = true; # Replaced by adw-bluetoth in hyprland
    programs.kdeconnect = {
      enable = true;
      package = pkgs.kdePackages.kdeconnect-kde;
    };
    programs.localsend = {
      enable = true;
      package = pkgs.localsend;
      openFirewall = true;
    };
    # Enable the OpenSSH daemon.
    services.openssh.enable = true;

    # DISABLE AND ENABLE TAILSCALE
    # services.tailscale = {
    #   enable = true;
    #   useRoutingFeatures = "both"; # Enables subnet routing and exit nodes if needed
    # };
    # KDE CONNECT PERMISSIONS
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}
