{ ... }:
{
  flake.nixosModules.grub =
    { config, pkgs, ... }:
    {
      boot.loader = {
        grub = {
          enable = true;
          device = "nodev";
          efiSupport = true;
        };
        efi.canTouchEfiVariables = true;
      };
    };

  flake.nixosModules.grubTheme =
    { config, pkgs, ... }:
    let
      theme = pkgs.stdenv.mkDerivation {
        pname = "bsol";
        version = "1.0";
        src = pkgs.fetchFromGitHub {
          owner = "harishnkr";
          repo = "bsol";
          rev = "afcc66069d104e4c02bc962e6bebd9c453c0f163";
          hash = "sha256-cj8yfdnR0n814piUZowUKEB2n9CWlsC97DScqxn7Cto=";
        };
        installPhase = "cp -r ./bsol $out";
      };
    in
    {
      environment.systemPackages = [ theme ];
      boot.loader.grub.theme = "${theme}";
    };
}
