{inputs, ...}: {
  flake.homeModules.mpd = {
    config,
    pkgs,
    ...
  }: {
    # Configure MPD service
    services.mpd = {
      enable = true;
      musicDirectory = "${config.home.homeDirectory}/Music"; # Properly reference home directory
      extraConfig = ''
        audio_output {
          type "pipewire"
          name "My PipeWire Output"
        }
      '';
      dataDir = "${config.home.homeDirectory}/.config/mpd"; # Absolute path using the home-manager variable
      playlistDirectory = "${config.home.homeDirectory}/.config/mpd/playlists"; # Also need absolute path
      network.listenAddress = "any"; # if you want to allow non-localhost connections
      network.startWhenNeeded = true; # systemd feature: only start MPD service upon connection to its socket
    };
  };
}
