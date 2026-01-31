{inputs, ...}: {
  flake.homeConfigurations.mana = inputs.self.modules.home-manager.mkConfig {
    hostName = "mana";
    modules = with inputs.self.homeModules; [
      home-manager
      git_mana-byte

      # terminal
      kitty
      starship

      #Desktop
      waybar
      hyprland
      gtk
      dunst

      # packages
      packages
    ];
  };
}
