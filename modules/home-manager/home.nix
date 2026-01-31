{inputs, ...}: {
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

      #Desktop
      waybar
      hyprland
      gtk
      dunst

      #Shell specific
      bashrc

      # packages
      packages
    ];
  };
}
