#!/usr/bin/env bash

grim - | wl-copy
notify-send -u critical "Full Screenshot Saved" "Screenshot was saved to your clipboard."
