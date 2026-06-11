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
        version = "0.11.8";
        src = pkgs.fetchFromGitHub {
          owner = "astral-sh";
          repo = "uv";
          tag = version;
          hash = "sha256-wu9EA3z/qj29lfSj8wKE4p8XEAJQakQTg2AK8I/64us=";
        };

        # See: https://github.com/Mic92/nix-update/issues/474#issuecomment-4149762084
        cargoDeps = pkgs.rustPlatform.fetchCargoVendor {
          inherit src;
          hash = "sha256-ygGRoZgD88Q2EkN0U4SDTwya96Ds3Pqy3Llj8cjGwnY=";
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
        dotenv-cli
        ngrok
        prettier
        biome
        cargo
        azure-cli
        uv0102
        python3
        terraform
        claude-code

        # system python packages
        mypy
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
