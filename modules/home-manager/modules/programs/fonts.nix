{ ... }:
{
  flake.homeModules.fonts =
    { config, pkgs, ... }:
    {
      fonts.fontconfig.enable = true;
      home.packages = with pkgs; [
        font-awesome
        nerd-fonts.jetbrains-mono
        nerd-fonts.departure-mono
      ];
    };
}
