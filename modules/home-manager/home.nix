{inputs, ...}: {
  flake.homeConfigurations.mana = inputs.self.modules.home-manager.mkConfig {
    hostName = "mana";
    modules = with inputs.self.homeModules; [
      home-manager
    ];
  };
}
