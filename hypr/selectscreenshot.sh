#!/usr/bin/env bash

grim -g "$(slurp)" - | wl-copy
notify-send -u critical "Select Screenshot Saved" "Screenshot was saved to your clipboard."
