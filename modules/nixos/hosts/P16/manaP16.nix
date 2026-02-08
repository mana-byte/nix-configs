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
      nvidiaP16
      cuda

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

      {
        nix.settings.substituters = [
          "https://cache.nixos-cuda.org"
        ];

        nix.settings.trusted-public-keys = [
          "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
        ];
      }
    ];
  };
}
