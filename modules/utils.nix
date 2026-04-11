{
  inputs,
  self,
  withSystem,
  ...
}:
{
  flake.modules.home-manager.mkConfig =
    {
      hostName,
      system ? "x86_64-linux",
      modules,
      stable ? false,
      nix-index-database ? false,
      homeStateVersion ? "24.05", # read before before changing
      ...
    }:
    withSystem "${system}" (
      { pkgs, ... }:
      let
        pkgsUsed =
          if stable then
            inputs.nixpkgs.legacyPackages.${system}
          else
            inputs.nixpkgs-unstable.legacyPackages.${system};
        nix-index-databaseModule =
          if nix-index-database then inputs.nix-index-database.homeModules.nix-index else { };
      in
      inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = pkgsUsed;
        modules = modules ++ [
          # Base home configuration for all hosts
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

  flake.modules.nixos.mkConfig =
    {
      user ? self.nixosModules.mana,
      packageModules ? [ ],
      systemModules ? [ ],
      allowUnfree ? true,
      experimentalFeatures ? [
        "nix-command"
        "flakes"
      ],
    }:
    inputs.nixpkgs.lib.nixosSystem {
      modules = [
        user
      ]
      ++ packageModules
      ++ systemModules
      ++ [
        {
          nixpkgs.config.allowUnfree = allowUnfree;
          nix.settings.experimental-features = experimentalFeatures;
        }
      ];
    };
}
