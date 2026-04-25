{ inputs, ... }:
{
  flake.homeModules.devPackages =
    {
      config,
      pkgs,
      ...
    }:
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
          # vibe
          uv
        ];
    };
}
