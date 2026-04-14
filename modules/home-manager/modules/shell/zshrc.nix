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
        };
        history.size = 10000;
      };
    };
}
