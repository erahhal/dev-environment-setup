#!/bin/bash

WALLPAPERS="~/Pictures/wallpapers/"

desktop_bg=$(find "$WALLPAPERS" -type f | shuf | head -n 1) && exec feh --bg-scale "$desktop_bg"
