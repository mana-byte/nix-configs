{ ... }:
{
  flake.homeModules.drift =
    {
      config,
      pkgs,
      ...
    }:
    {
      home.packages = with pkgs; [
        drift
      ];
    };
}
