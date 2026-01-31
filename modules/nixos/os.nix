{
  inputs,
  self,
  ...
}: {
  flake.nixos.manaP16 = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.modules.nixos.configurationP16
      self.modules.nixos.hardwareP16
    ];
  };
}
