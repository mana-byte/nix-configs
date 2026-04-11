{ inputs, ... }:
{
  flake.homeModules.fastfetch =
    {
      config,
      pkgs,
      ...
    }:
    {
      programs.fastfetch = {
        enable = true;
        settings = {
          logo = {
            type = "file";
            source = "~/.config/me/fastfetch/knight.txt";
          };
          modules = [
            "os"
            "host"
            "uptime"
            "cpu"
            "gpu"
            "memory"
            "disk"
            "battery"
            "shell"
            "terminal"
            "de"
            "wm"
            "theme"
            "font"
          ];
        };
      };
    };
}
