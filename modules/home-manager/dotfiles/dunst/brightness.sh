#!/usr/bin/env bash

# Usage: brightness-notify.sh [up|down]

STEP=5

case "$1" in
  up)
    brightnessctl set "$STEP%+"
    ;;
  down)
    brightnessctl set "$STEP%-"
    ;;
  *)
    echo "Usage: $0 [up|down]"
    exit 1
    ;;
esac

BRIGHT=$(brightnessctl get)
MAX=$(brightnessctl max)
PCT=$(( BRIGHT * 100 / MAX ))

BAR_LENGTH=20
FILLED=$(( PCT * BAR_LENGTH / 100 ))
EMPTY=$(( BAR_LENGTH - FILLED ))
BAR=$(printf '█%.0s' $(seq 1 $FILLED))
BAR+=$(printf '─%.0s' $(seq 1 $EMPTY))

ICON=""

dunstify -r 2594 -u normal "$ICON Brightness: $PCT%" "$BAR" -t 1500
