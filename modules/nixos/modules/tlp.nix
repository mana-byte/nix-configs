{inputs, ...}: {
  flake.nixosModules.tlp = {
    config,
    pkgs,
    ...
  }: {
    # tlp for battery management
    services.tlp = {
      enable = true;
      settings = {
        # AC settings
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        # Battery settings
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        # Battery settings
        CPU_ENERGY_PERF_POLICY_ON_BAT = "powersave";
        # AC settings
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      };
    };
  };
}
