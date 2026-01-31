{inputs, ...}: {
  flake.nixosModules.hyprlandOS = {
    config,
    pkgs,
    ...
  }: {
    programs.hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };
  };
}
