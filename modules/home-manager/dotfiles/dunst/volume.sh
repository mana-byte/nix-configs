#!/usr/bin/env bash

# Usage: volume.sh [up|down|toggle]

STEP=5

case "$1" in
  up)
    pamixer --increase $STEP
    ;;
  down)
    pamixer --decrease $STEP
    ;;
  toggle)
    pamixer --toggle-mute
    ;;
  *)
    echo "Usage: $0 [up|down|toggle]"
    exit 1
    ;;
esac

VOL=$(pamixer --get-volume)
MUTED=$(pamixer --get-mute)

BAR_LENGTH=20
if [ "$MUTED" = "true" ]; then
    BAR="Muted"
    ICON=""
else
    FILLED=$(( VOL * BAR_LENGTH / 100 ))
    EMPTY=$(( BAR_LENGTH - FILLED ))
    BAR=$(printf '█%.0s' $(seq 1 $FILLED))
    BAR+=$(printf '─%.0s' $(seq 1 $EMPTY))
    ICON=""
fi

dunstify -r 2593 -u normal "$ICON Volume: $VOL%" "$BAR" -t 1500

