{ input, ... }:
{
  flake.homeModules.gamePackages =
    {
      config,
      pkgs,
      ...
    }:
    {
      nixpkgs.config.allowUnfree = true;
      home.packages = with pkgs; [
        # minecraft
        modrinth-app
      ];
    };
}
