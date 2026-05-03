{ inputs, withSystem, ... }:
{
  flake.homeConfigurations.mana = inputs.builders.lib.home.mkConfig {
    hostName = "mana";
    nix-index-database = true;
    homeStateVersion = "24.05";
    withSystem = withSystem "x86_64-linux";
    manager = inputs.home-manager;
    modules = with inputs.self.homeModules; [
      git_mana-byte

      # terminal
      kitty
      starship
      fastfetch
      # drift # not available for nixpkgs-25.11

      #Desktop
      waybar
      hyprland
      gtk
      dunst
      mpd
      meAssets

      #Shell specific
      zshrc
      # bashrc

      # packages
      desktopPackages
      devPackages
      gamePackages
    ];
  };
}
