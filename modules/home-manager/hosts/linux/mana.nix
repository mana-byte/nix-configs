{ inputs, ... }:
{
  flake.homeConfigurations.mana = inputs.self.modules.home-manager.mkConfig {
    hostName = "mana";
    nix-index-database = true;
    homeStateVersion = "24.05";
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
