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
    ...
  }:
    withSystem "${system}" (
      {pkgs, ...}: let
        pkgsUsed =
          if stable
          then inputs.nixpkgs.legacyPackages.${system}
          else inputs.nixpkgs-unstable.legacyPackages.${system};
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
            ];
        }
    );
}
