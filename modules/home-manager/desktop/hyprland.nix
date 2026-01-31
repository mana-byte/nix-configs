{
  inputs,
  self,
  ...
}: {
  flake.homeModules.hyprland = {
    config,
    pkgs,
    ...
  }: {
    xdg.configFile."hypr".source = ../dotfiles/hypr;
    wayland.windowManager.hyprland.enable = true;
    wayland.windowManager.hyprland.settings = {
      configFile = "~/.config/hypr/hyprland.conf";
    };
  };
}
