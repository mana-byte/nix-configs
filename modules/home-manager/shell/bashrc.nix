{inputs, ...}: {
  flake.homeModules.bashrc = {
    #BASHRC AND ALIASES
    programs.bash = {
      enable = true;
      initExtra = ''
        eval "$(starship init bash)"
        alias nvf="nvim"
        alias sudo="sudo "
        alias CD="cd ~/Desktop"
        alias OSRC="cd ~/Desktop/OPEN_SOURCE"
        alias neofetch="fastfetch"

        # Drift
        export DRIFT_TIMEOUT=120
        eval "$(drift shell-init bash)"
      '';
    };
  };
}
