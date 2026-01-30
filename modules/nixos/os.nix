{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.manaP16 = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.configuration
      self.nixosModules.hardware
    ];
  };
}
