{ inputs, ... }:
inputs.builders.lib.mkOsModule {
  name = "gc30d";
  configuration =
    { config, pkgs, ... }:
    {
      nix.gc = {
        automatic = true;
        dates = "monthly";
        options = "--delete-older-than 30d";
      };
    };
}
