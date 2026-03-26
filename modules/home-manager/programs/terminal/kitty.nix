{inputs, ...}: {
  flake.homeModules.kitty = {
    config,
    pkgs,
    ...
  }: let
    kittyCardsScript = ''
      #!/usr/bin/env bash
      # Script to set random image and apply its colors to the current kitty window only
      IMG_DIR="$HOME/.config/me/cards/cans/"

      # Ensure the image directory exists
      if [ ! -d "$IMG_DIR" ]; then
          echo "Creating image directory: $IMG_DIR"
          mkdir -p "$IMG_DIR"
          echo "Please add some images to $IMG_DIR"
          exit 1
      fi

      # Check if any images exist
      image_count=$(find "$IMG_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | wc -l)
      if [ "$image_count" -eq 0 ]; then
          echo "No images found in $IMG_DIR"
          exit 1
      fi

      # Check if we're running inside kitty
      if [ -z "$KITTY_WINDOW_ID" ]; then
          echo "This script must be run inside a kitty terminal."
          exit 1
      fi

      # Check if pywal is installed
      # if ! command -v wal &> /dev/null; then
      #     echo "pywal is not installed. Please install it first:"
      #     echo "pip install pywal"
      #     exit 1
      # fi

      # Pick a random image
      IMG=$(find "$IMG_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | shuf -n 1)

      # Make sure we found an image
      if [ -z "$IMG" ] || [ ! -f "$IMG" ]; then
          echo "Failed to find a valid image."
          exit 1
      fi

      # Generate colors with pywal but without changing other applications (-n flag)
      # Also using -q for quiet mode
      # wal -i "$IMG" -s -q

      # Wait briefly to ensure Kitty is fully initialized
      sleep 0.5

      # Apply the colors ONLY to the current window using kitty's remote control protocol
      # if [ -f "$HOME/.cache/wal/colors-kitty.conf" ]; then
      #     # Instead of creating a temp file, pipe directly to kitty
      #     cat "$HOME/.cache/wal/colors-kitty.conf" | kitty @ set-colors --configured --match "id:$KITTY_WINDOW_ID" ~/.cache/wal/colors-kitty.conf
      # else
      #     echo "Failed to find wal color cache. Something went wrong with pywal."
      #     exit 1
      # fi

      # Set the colors for the current kitty window
      cat "$HOME/.cache/wal/colors-kitty.conf" | kitty @ set-colors --configured --match "id:$KITTY_WINDOW_ID" ~/.cache/wal/colors-kitty.conf

      # Display the image using kitty's icat
      kitty +kitten icat --align left "$IMG"

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
