{inputs, ...}: {
  flake.nixosModules.displayManagerGDM = {
    config,
    pkgs,
    ...
  }: {
    services.xserver.enable = true;
    services.xserver.displayManager.gdm.enable = true;
  };
}
