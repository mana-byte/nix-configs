{inputs, ...}: {
  flake.nixosModules.basicGraphics = {
    config,
    pkgs,
    ...
  }: {
    # Configure OpenGL properly
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
