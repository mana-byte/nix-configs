{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.manaP16 = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      # P16 specific
      configurationP16
      hardwareP16
      # nvidiaP16

      # Modules
      asusd
      audio
      basicPackages
      basicGraphics
      basicConnection
      displayManagerGDM
      font
      hyprlandOS
      languageFr
      tlp
      usbAutoMount
      gc30d

      # user
      mana
    ];
  };
}
