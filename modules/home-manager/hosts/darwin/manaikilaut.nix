{ inputs, ... }:
{
  flake.homeConfigurations."manaiki.laut" = inputs.self.modules.home-manager.mkConfig {
    hostName = "manaiki.laut";
    system = "aarch64-darwin";
    nix-index-database = true;
    homeStateVersion = "24.05";
    modules = with inputs.self.homeModules; [
      # terminal
      kitty
      starship
      fastfetch
      fonts
      zshrc

      #Desktop
      meAssets

      # packages
      devPackages
      mistralDevModule
    ];
  };
}
