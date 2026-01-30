{
  inputs,
  self,
  ...
}: {
  xdg.configFile."hypr".source = ../../dotfiles/hypr;
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.settings = {
    configFile = "~/.config/hypr/hyprland.conf";
  };
}
