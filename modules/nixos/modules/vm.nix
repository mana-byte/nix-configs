{ inputs, ... }:
{
  flake.nixosModules.vm =
    {
      config,
      pkgs,
      ...
    }:
    {
      virtualisation.libvirtd = {
        enable = true;

        # Enable TPM emulation (for Windows 11)
        qemu = {
          swtpm.enable = true;
        };
      };

      users.groups.libvirtd.members = [ "mana" ];
      users.groups.kvm.members = [ "mana" ];

      # Enable USB redirection
      virtualisation.spiceUSBRedirection.enable = true;

      environment.systemPackages = with pkgs; [
        gnome-boxes
        dnsmasq
      ];

    };
}
