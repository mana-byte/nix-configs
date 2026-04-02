{ inputs, ... }:
{
  flake.homeConfigurations.mana = inputs.self.modules.home-manager.mkConfig {
    hostName = "mana";
    nix-index-database = true;
    # Set home state version
    homeStateVersion = "24.05";
    modules = with inputs.self.homeModules; [
      git_mana-byte

      # terminal
      kitty
      starship
      fastfetch

      #Desktop
      waybar
      hyprland
      gtk
      dunst
      mpd
      meAssets

      #Shell specific
      bashrc

      # packages
      desktopPackages
      devPackages
      # gamePackages
    ];
  };
}
