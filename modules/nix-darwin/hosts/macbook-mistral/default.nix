{ inputs, self, ... }:
{
  flake.darwinConfigurations.mistral =
    let
      primaryUser = "manaiki.laut";
      baseConfiguration =
        { pkgs, ... }:
        {
          environment.systemPackages = with pkgs; [
            home-manager
            vim
            git
            discord
            cowsay
            nh
          ];

          # programs.nh = {
          #   enable = true;
          #   clean.enable = true;
          #   flake = "/Users/${primaryUser}/Desktop/nix-configs";
          # };

          # Necessary for using flakes on this system.
          nix.settings.experimental-features = "nix-command flakes";
          nix.enable = false;
          nixpkgs.config.allowUnfree = true;

          homebrew = {
            enable = true;
            # CLI APPS
            brews = [
              "freetype"
              "libmagic"
              "bruno-cli"
              "libiconv"
            ];
            # UI APPS
            casks = [
              "bruno"
              "nikitabobko/tap/aerospace"
            ];
          };

          # Set Git commit hash for darwin-version.
          system.configurationRevision = self.rev or self.dirtyRev or null;
          # $ darwin-rebuild changelog
          system.stateVersion = 6;

          system.primaryUser = primaryUser;

          # The platform the configuration will be used on.
          nixpkgs.hostPlatform = "aarch64-darwin";
        };
    in
    inputs.nix-darwin.lib.darwinSystem {
      modules = [
        baseConfiguration
      ];
    };
}
