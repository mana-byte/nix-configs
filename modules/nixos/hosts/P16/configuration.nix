{
  ...
}:
{
  flake.nixosModules.configurationP16 =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    {
      ### Basic System Settings
      services.logind.settings.Login = {
        HandleLidSwitchDocked = "ignore";
        HandleLidSwitch = "poweroff";
        HandleLidSwitchExternalPower = "lock";
      };

      ### amdgpu
      services.xserver.videoDrivers = [ "amdgpu" ];
      boot.initrd.kernelModules = [ "amdgpu" ];

      ### Programs
      security.polkit.enable = true;
      programs.nh = {
        enable = true;
        clean.enable = true;
        flake = "/home/mana/Desktop/nix-configs";
      };
      programs.mtr.enable = true;
      programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
      };
      virtualisation.docker.enable = true;

      environment.sessionVariables = {
        WLR_NO_HARDWARE_CURSOR = "1";
        NIXOS_OZONE_WL = "1";
      };

      ### BOOT and Sytem
      boot.extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];

      # Bootloader.
      # boot.loader.systemd-boot.enable = true;
      # boot.loader.efi.canTouchEfiVariables = true;

      boot.kernelPackages = pkgs.linuxPackages_6_18;

      boot.kernelParams = [
        "amd_pstate=active" # Better power management
        "amdgpu.sg_display=0" # Address graphics stability
        "amdgpu.runpm=0" # Disable run-time power management
        "acpi_osi=Linux" # ACPI compatibility
        "acpi_enforce_resources=lax"
      ];

      hardware.enableRedistributableFirmware = true;
      hardware.enableAllFirmware = true;
    };
}
