{ inputs, ... }:
{
  flake.nixosModules.nvidiaP16 =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    {
      services.xserver.videoDrivers = [ "nvidia" ]; # add nvidia
      # Configure NVIDIA with safe options
      hardware.nvidia = {
        package = config.boot.kernelPackages.nvidiaPackages.stable;
        modesetting.enable = true;
        powerManagement.enable = true;
        powerManagement.finegrained = true;
        open = true;
        dynamicBoost.enable = true;
        prime = {
          sync.enable = lib.mkForce false;
          offload = {
            enable = lib.mkForce true;
            enableOffloadCmd = lib.mkForce true;
          };
          amdgpuBusId = "PCI:65:0:0";
          nvidiaBusId = "PCI:64:0:0";
        };
        nvidiaSettings = true;
      };
      environment.systemPackages = with pkgs; [
        nvtopPackages.nvidia
      ];
    };
}
