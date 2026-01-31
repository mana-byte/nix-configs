{...}: {
  flake.homeModules.git_mana-byte = {
    config,
    pkgs,
    ...
  }: {
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = "mana-byte";
          email = "manaikilaut@gmail.com";
        };
        init.defaultBranch = "main";
        pull.rebase = false;
        credential.helper = "store";
        color.ui = "auto";
      };
    };
  };
}
