{ inputs, ... }:
{
  flake.nixosModules.cobblemonServer =
    {
      config,
      pkgs,
      ...
    }:
    let
      port = 25566;
    in
    {
      imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
      nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

      services.minecraft-servers = {
        enable = true;
        eula = true;
        openFirewall = true;
        servers.cobbleverse = {
          enable = true;
          package = pkgs.fabricServers.fabric-1_21_1;

          # 8GB max heap, 2GB initial heap. Adjust as needed.
          jvmOpts = "-Xmx8G -Xms2G";

          serverProperties = {
            gamemode = "survival";
            difficulty = "normal";
            simulationDistance = 10;
            server-port = port;
          };
          symlinks = {
            mods = ./modpacks/cobbleverse/mods;
          };
        };
      };
    };
}
