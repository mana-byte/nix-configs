{inputs, ...}: {
  flake.homeModules.kitty = {
    config,
    pkgs,
    ...
  }: let
    kittyCardsScript = ''
    #!/usr/bin/env bash
    # Script to display random ASCII art and apply cached colors to the current kitty window only
    ASCII_DIR="$HOME/.config/me/cards/ascii/"

    # Ensure the ASCII directory exists
    if [ ! -d "$ASCII_DIR" ]; then
        echo "Creating ASCII art directory: $ASCII_DIR"
        mkdir -p "$ASCII_DIR"
        echo "Please add some ASCII art text files to $ASCII_DIR"
        exit 1
    fi

    # Check if any files exist in the directory
    # (Finds all standard files, assuming you only keep text/ascii files in this folder)
    ascii_count=$(find "$ASCII_DIR" -type f | wc -l)
    if [ "$ascii_count" -eq 0 ]; then
        echo "No ASCII art files found in $ASCII_DIR"
        exit 1
    fi

    # Check if we're running inside kitty
    if [ -z "$KITTY_WINDOW_ID" ]; then
        echo "This script must be run inside a kitty terminal."
        exit 1
    fi

    # Pick a random ASCII file
    ASCII_FILE=$(find "$ASCII_DIR" -type f | shuf -n 1)

    # Make sure we found a valid file
    if [ -z "$ASCII_FILE" ] || [ ! -f "$ASCII_FILE" ]; then
        echo "Failed to find a valid ASCII art file."
        exit 1
    fi

    # Wait briefly to ensure Kitty is fully initialized
    sleep 0.5

    # Set the colors for the current kitty window 
    # (Requires 'allow_remote_control yes' in kitty.conf)
    kitty @ set-colors --configured --match "id:$KITTY_WINDOW_ID" ~/.cache/wal/colors-kitty.conf

    # Display the ASCII art
    cat "$ASCII_FILE"

    exit 0
    '';
  in {
    programs.kitty = {
      enable = true;
      settings = {
        confirm_os_window_close = 0;
        background_opacity = 1.0;
        allow_remote_control = true;

        # Startup session and shell command
        startupSession = "none";
        shell = "bash --login -c '${config.home.homeDirectory}/.config/kitty/kitty_cards.sh; exec bash'";

        font_family = "DepartureMono Nerd Font";
        bold_font = "DepartureMono Nerd Font";
        italic_font = "DepartureMono Nerd Font";
        bold_italic_font = "DepartureMono Nerd Font";

        font_size = 12.0;
      };
    };
    home.file.".config/kitty/kitty_cards.sh" = {
      text = kittyCardsScript;
      executable = true;
    };
  };
}
