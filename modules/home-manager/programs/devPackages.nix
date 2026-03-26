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

      home.packages = with pkgs; [
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
        clipman

        # NIx prefetch scripts
        nix-prefetch-scripts
        # nixpkgs review
        nixpkgs-review

        # Useful TUI apps
        lazydocker

        # coding cli
        mistral-vibe

        # nvf dependencies
        nodejs
        gcc
        ripgrep

        # python
        uv
        python3

        dotenv-cli
      ];
    };
}
