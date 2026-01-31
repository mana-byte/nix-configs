{inputs, ...}: {
  flake.nixosModules.mana = {
    config,
    pkgs,
    ...
  }: {
    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.mana = {
      isNormalUser = true;
      description = "Mana";
      extraGroups = ["networkmanager" "wheel" "docker"];
      packages = with pkgs; [];
    };
  };
}
