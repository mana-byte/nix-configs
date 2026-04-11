{inputs, ...}: {
  flake.homeModules.gtk = {
    config,
    pkgs,
    ...
  }: {
    #GTK
    gtk = {
      enable = true;
      theme = {
        name = "catppuccin-frappe-blue-standard";
        package = pkgs.catppuccin-gtk;
        # package = pkgs.nwg-look;
      };
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.catppuccin-papirus-folders;
      };
      cursorTheme = {
        name = "Bibata-Modern-Classic";
        package = pkgs.bibata-cursors;
        size = 24;
      };
      font.name = "DepartureMono Nerd Font";
    };
  };
}
