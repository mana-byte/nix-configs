{
  ...
}: {
  flake.homeModules.meAssets = {
    config,
    pkgs,
    ...
  }: {
    xdg.configFile."me".source = ../dotfiles/me;
  };
}
