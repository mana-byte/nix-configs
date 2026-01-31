{inputs, ...}: {
  flake.nixosModules.asusd = {
    config,
    pkgs,
    ...
  }: {
    # for deactivating the gpu when not needed
    # There is an option at the top in kernel params to set initial mode of gpu
    services.supergfxd.enable = true;
    # Ensure the service is properly enabled
    systemd.services.asusd.enable = true;
    # ASUSD Configuration - Enhanced
    services.asusd = {
      enable = true;
      enableUserService = true;
      package = pkgs.asusctl;
    };

    # Make sure asusd starts after basic system services
    systemd.services.asusd = {
      after = ["multi-user.target"];
      wantedBy = ["multi-user.target"];
    };
  };
}
