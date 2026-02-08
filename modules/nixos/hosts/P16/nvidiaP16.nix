{inputs, ...}: {
  flake.nixosModules.nvidiaP16 = {
    config,
    pkgs,
    ...
  }: {
    services.xserver.videoDrivers = ["nvidia"]; # add nvidia
    # Configure NVIDIA with safe options
    hardware.nvidia = {
      modesetting.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      open = true;
      dynamicBoost.enable = true;
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        amdgpuBusId = "PCI:65:0:0";
        nvidiaBusId = "PCI:64:0:0";
      };
      nvidiaSettings = true;
      powerManagement.enable = true;
      powerManagement.finegrained = true;
    };
    environment.systemPackages = with pkgs; [
      nvtopPackages.nvidia
    ];
  };
}
