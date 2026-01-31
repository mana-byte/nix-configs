{
  inputs,
  withSystem,
  ...
}: {
  flake.homeConfigurations.mana = withSystem "x86_64-linux" (
    {pkgs, ...}:
      inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          {
            # user home config
          }
        ];
      }
  );

  flake.modules.home-manager.home = {
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
      # MPD_HOST = "localhost:6600";
    };

    #BASHRC AND ALIASES
    programs.bash = {
      enable = true;
      initExtra = ''
        eval "$(starship init bash)"
        alias sudo="sudo "
        alias CD="cd ~/Desktop"
        alias OSRC="cd ~/Desktop/OPEN_SOURCE"
      '';
    };

    programs.home-manager.enable = true;
    home.enableNixpkgsReleaseCheck = true;
  };
}
