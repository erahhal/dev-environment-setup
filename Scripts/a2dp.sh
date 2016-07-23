#!/bin/bash

# HEADSET_INDEX=$(pacmd list-cards | grep -B 1 bluez | awk '{print $2; exit}')
# pacmd set-card-profile $HEADSET_INDEX a2dp
echo "Getting bluetooth device id..."
HEADSET_ID=$(pactl list cards short | grep blue | awk '{print $1}')
echo "Setting to a2dp..."
pactl set-card-profile $HEADSET_ID a2dp
