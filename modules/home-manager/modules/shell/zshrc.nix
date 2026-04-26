{ ... }:
{
  flake.homeModules.zshrc =
    { config, pkgs, ... }:
    {
      programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;

        shellAliases = {
          l = "ls -la";
          cdconfig = "cd $HOME/Desktop/nix-configs";
          CD = "cd $HOME/Desktop";
          nvf = "nvim";
          neofetch = "fastfetch";
          OSRC = "cd $HOME/Desktop/OPEN_SOURCE";
        };
        initContent = ''
          eval "$(starship init zsh)"
          export DRIFT_TIMEOUT=120
          eval "$(drift shell-init zsh)"
        '';
        history.size = 10000;
      };
    };
}
