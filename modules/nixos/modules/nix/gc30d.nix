{inputs, ...}: {
  flake.nixosModules.gc30d = {
    config,
    pkgs,
    ...
  }: {
    nix.gc = {
      automatic = true;
      dates = "monthly"; # runs on the 1st of every month by default
      options = "--delete-older-than 30d";
    };
  };
}
