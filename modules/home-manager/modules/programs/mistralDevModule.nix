{ ... }:
{
  flake.homeModules.mistralDevModule =
    {
      config,
      pkgs,
      ...
    }:
    let
      uv0102 = pkgs.uv.overrideAttrs (old: rec {
        inherit (old) pname;
        version = "0.10.2";
        src = pkgs.fetchFromGitHub {
          owner = "astral-sh";
          repo = "uv";
          tag = version;
          hash = "sha256-7huzemS9BLCOmfzr2cSd8Tc4PtTJV0peYQ5FN2VaPKw=";
        };

        # See: https://github.com/Mic92/nix-update/issues/474#issuecomment-4149762084
        cargoDeps = pkgs.rustPlatform.fetchCargoVendor {
          inherit src;
          hash = "sha256-kSpRcliQpCCjpZUSCwd9THszOSmdXDIooJA4ZPtRjvo=";
        };
      });
    in
    {
      nixpkgs.config.allowUnfree = true;
      home.packages = with pkgs; [
        # Mistral ai dashboard deps
        pnpm
        fnm
        gnumake
        python3
        dotenv-cli
        ngrok
        prettier
        biome
        cargo
        azure-cli
        uv0102
      ];
      programs.zsh = {
        enable = true;
        initContent = ''
          export PATH="$HOME/Desktop/dashboard/ts/node_modules/.bin:$PATH"
          eval "$(fnm env --use-on-cd --shell zsh)"
        '';
      };
    };
}
