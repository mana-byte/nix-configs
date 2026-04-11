{
  inputs,
  self,
  ...
}:
{
  flake.nixosConfigurations.manaP16 = inputs.self.modules.nixos.mkConfig {
    user = self.nixosModules.mana;
    allowUnfree = true;
    stateVersion = "25.11";
    packageModules = with self.nixosModules; [
      gaming
      basicPackages
      font
    ];
    systemModules = with self.nixosModules; [
      # P16 specific
      configurationP16
      nvidiaP16

      # graphics and ui
      basicGraphics
      hyprlandOS
      displayManagerGDM
      languageFr

      # System
      asusd
      audio
      tlp
      basicConnection
      usbAutoMount
      gc30d
      # cuda
      # vm
    ];
  };
}
