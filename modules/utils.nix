{
  inputs,
  withSystem,
  ...
}: {
  flake.modules.home-manager.mkConfig = {
    hostName,
    system ? "x86_64-linux",
    modules,
    ...
  }:
    withSystem "${system}" (
      {pkgs, ...}:
        inputs.home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules =
            modules
            ++ [
              {
                home.username = hostName;
                home.homeDirectory = "/home/${hostName}";
              }
            ];
        }
    );
}
