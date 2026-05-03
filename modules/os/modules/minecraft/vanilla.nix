{ inputs, ... }:

{
  flake.nixosModules.vanilla =
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
      networking.firewall.allowedTCPPorts = [ port ];

      services.minecraft-servers = {
        enable = true;
        eula = true;
        servers.vanilla = {
          enable = true;
          jvmOpts = "-Xmx8G -Xms2G";
          package = pkgs.fabricServers.fabric-26_1;
          serverProperties = {
            gamemode = "survival";
            difficulty = "normal";
            simulationDistance = 10;
            server-port = port;
          };
        };
      };
    };
}

