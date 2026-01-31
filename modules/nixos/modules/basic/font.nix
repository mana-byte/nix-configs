{inputs, ...}: {
  flake.nixosModules.font = {
    config,
    pkgs,
    ...
  }: {
    fonts.fontconfig.enable = true;
    fonts.packages = with pkgs; [
      font-awesome
      nerd-fonts.jetbrains-mono
      nerd-fonts.departure-mono
    ];
  };
}
