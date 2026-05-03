{
  description = "Make configs easier";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    {
      lib = {

        # Helper function to create nixos and darwin modules at the same time
        mkOsModule =
          {
            name,
            configuration,
            scope ? [
              "linux"
              "darwin"
            ],
          }:
          {
            flake =
              (nixpkgs.lib.optionalAttrs (builtins.elem "linux" scope) {
                nixosModules.${name} = configuration;
              })
              // (nixpkgs.lib.optionalAttrs (builtins.elem "darwin" scope) {
                darwinModules.${name} = configuration;
              });
          };

        nixos.mkConfig =
          {
            user,
            packageModules ? [ ],
            systemModules ? [ ],
            stateVersion,
            allowUnfree ? true,
            experimentalFeatures ? [
              "nix-command"
              "flakes"
            ],
          }:
          nixpkgs.lib.nixosSystem {
            modules = [
              user
            ]
            ++ packageModules
            ++ systemModules
            ++ [
              {
                nixpkgs.config.allowUnfree = allowUnfree;
                nix.settings.experimental-features = experimentalFeatures;
                system.stateVersion = "${stateVersion}";
              }
            ];
          };

        home.mkConfig =
          {
            hostName,
            modules,
            stable ? false,
            nix-index-database ? false,
            homeStateVersion,
            withSystem,
            manager,
            ...
          }:
          withSystem (
            { pkgs, system, ... }:
            let
              pkgsUsed =
                if stable then
                  inputs.nixpkgs.legacyPackages.${system}
                else
                  inputs.nixpkgs-unstable.legacyPackages.${system};
              nix-index-databaseModule =
                if nix-index-database then inputs.nix-index-database.homeModules.nix-index else { };
            in
            manager.lib.homeManagerConfiguration {
              pkgs = pkgsUsed;
              modules = modules ++ [
                # Base home configuration for all hosts
                {
                  home.username = hostName;
                  home.homeDirectory =
                    if system == "aarch64-darwin" then "/Users/${hostName}" else "/home/${hostName}";
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

      };
    };
}
