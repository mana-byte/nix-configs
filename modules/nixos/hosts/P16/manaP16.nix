{
  inputs,
  self,
  ...
}:
{
  flake.nixosConfigurations.manaP16 = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      # P16 specific
      configurationP16
      hardwareP16
      nvidiaP16

      # graphics and ui
      basicGraphics
      hyprlandOS
      displayManagerGDM
      languageFr
      font

      # System
      asusd
      audio
      tlp
      basicConnection
      usbAutoMount
      gc30d
      # cuda
      # vm

      # packages and softwares
      gaming
      basicPackages

      # user
      mana
    ];
  };
}
