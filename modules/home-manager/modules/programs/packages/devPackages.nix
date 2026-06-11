{ inputs, ... }:
{
  flake.homeModules.devPackages =
    {
      config,
      pkgs,
      ...
    }:
    let
      devenv21 = pkgs.devenv.overrideAttrs(old: rec {
        inherit (old) pname;
        version = "2.1";
        src = pkgs.fetchFromGitHub {
          owner = "cachix";
          repo = "devenv";
          tag = "v2.1";
          hash = "sha256-U7rb9FufadyCBLLsxVY6AJfy6TN24+uwaBBh8JVOP8s=";
        };

        cargoDeps = pkgs.rustPlatform.fetchCargoVendor {
          inherit src;
          hash = "sha256-aONHe6r+lvXC45y6QeJ/tnVSHAYhy2IGuGWCrz+KVWc=";
        };
      });
    in
    {
      nixpkgs.config.allowUnfree = true;

      home.packages =
        with pkgs;
        [
          # system info : battery health, cpu temp, memory usage, disk usage, etc.
          inxi
          tldr

          #run software without installation requires nix index db in flake input
          comma

          # kill all processes of a specific name
          killall
          # work basics
          neovim
          gh
          tmux

          # NIx prefetch scripts
          nix-prefetch-scripts
          # nixpkgs review
          nixpkgs-review

          # Useful TUI apps
          lazydocker

          # nvf dependencies
          nodejs
          gcc
          ripgrep

          # python
          # uv
          python3
          ruff

          dotenv-cli
        ]
        ++ lib.optionals stdenv.hostPlatform.isLinux [
          # linux specific tools
          clipman
          uv
          # devenv with secret management
          # devenv
          devenv21
          secretspec
          bitwarden-cli
          bws
        ];
    };
}
