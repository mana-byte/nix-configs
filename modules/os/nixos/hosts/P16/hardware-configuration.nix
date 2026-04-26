{
  inputs,
  self,
  ...
}:
{
  flake.nixosModules.hardwareP16 =
    {
      config,
      lib,
      pkgs,
      modulesPath,
      ...
    }:
    {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
      ];

      boot.initrd.availableKernelModules = [
        "nvme"
        "xhci_pci"
        "thunderbolt"
        "usbhid"
        "usb_storage"
        "sd_mod"
        "sdhci_pci"
      ];
      boot.initrd.kernelModules = [ ];
      boot.kernelModules = [ "kvm-amd" ];
      boot.extraModulePackages = [ ];

      fileSystems."/" = {
        device = "/dev/mapper/luks-8502b424-321f-4f4c-81e5-fc28463222ba";
        fsType = "ext4";
      };

      boot.initrd.luks.devices."luks-8502b424-321f-4f4c-81e5-fc28463222ba".device =
        "/dev/disk/by-uuid/8502b424-321f-4f4c-81e5-fc28463222ba";

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/FD1B-705C";
        fsType = "vfat";
        options = [
          "fmask=0077"
          "dmask=0077"
        ];
      };

      swapDevices = [ ];

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
}
