{inputs, ...}: {
  flake.homeModules.home-manager = {
    config,
    pkgs,
    ...
  }: {
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
        alias nvf="nvim"
        alias sudo="sudo "
        alias CD="cd ~/Desktop"
        alias OSRC="cd ~/Desktop/OPEN_SOURCE"
      '';
    };

    programs.home-manager.enable = true;
    home.enableNixpkgsReleaseCheck = true;
  };
}
