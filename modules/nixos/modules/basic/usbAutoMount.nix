{inputs, ...}: {
  flake.nixosModules.usbAutoMount = {
    config,
    pkgs,
    ...
  }: {
    # usb auto mounting
    services.gvfs.enable = true;
    services.udisks2.enable = true;
    services.dbus.enable = true;
  };
}
