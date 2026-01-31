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
    homeStateVersion ? "24.05", # read before before changing
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
                home.stateVersion = homeStateVersion;
                home.sessionVariables = {
                  EDITOR = "nvim";
                };

                # Let home manager manage itself
                programs.home-manager.enable = true;
                home.enableNixpkgsReleaseCheck = true;
              }
              nix-index-databaseModule
            ];
        }
    );
}
