{
  inputs,
  withSystem,
  ...
}: {
  flake.modules.home-manager.mkConfig = {
    hostName,
    system ? "x86_64-linux",
    modules,
    stable ? false,
    nix-index-database ? false,
    ...
  }:
    withSystem "${system}" (
      {pkgs, ...}: let
        pkgsUsed =
          if stable
          then inputs.nixpkgs.legacyPackages.${system}
          else inputs.nixpkgs-unstable.legacyPackages.${system};
        nix-index-databaseModule =
          if nix-index-database
          then inputs.nix-index-database.homeModules.nix-index
          else {};
      in
        inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsUsed;
          modules =
            modules
            ++ [
              {
                home.username = hostName;
                home.homeDirectory = "/home/${hostName}";
              }
              nix-index-databaseModule
            ];
        }
    );
}
