{
  inputs,
  self,
  ...
}: {
  flake.homeConfigurations.mana = inputs.home-manager.lib.homeManagerConfiguration {
    modules = [
      self.flake.homeModules.homeModule
      self.flake.homeModules.packages

      # NOTE: CUSTOMISATION MODULES
      # WARNING: source folder
      self.flake.homeModules.hyprlandModule
      self.flake.homeModules.starfishModule
      self.flake.homeModules.kittyModule
      # WARNING: source folder
      self.flake.homeModules.waybarModule
      # WARNING: source folder
      self.flake.homeModules.dunstModule
    ];
  };

  flake.homeModules.homeModule = {
    config,
    pkgs,
    ...
  }: {
    home.username = "mana";
    home.homeDirectory = "/home/mana";

    home.stateVersion = "24.05"; # Please read the comment before changing.

    # SESSION VARIABLES
    home.sessionVariables = {
      EDITOR = "nvim";
      MPD_HOST = "localhost:6600";
    };

    #BASHRC AND ALIASES
    programs.bash = {
      enable = true;
      initExtra = ''
        eval "$(starship init bash)"
        alias nvf="nix run ~/nvim"
        alias sudo="sudo "
        alias CD="cd ~/Desktop"
        alias OSRC="cd ~/Desktop/OPEN_SOURCE"
      '';
    };

    programs.home-manager.enable = true;
    home.enableNixpkgsReleaseCheck = true;
  };
}
