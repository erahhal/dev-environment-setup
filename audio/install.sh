#!/bin/bash

set -e

# KXStudio
KXSTUDIO=kxstudio-repos_9.4.6~kxstudio1_all.deb
sudo apt-get install apt-transport-https software-properties-common wget
wget https://launchpad.net/~kxstudio-debian/+archive/kxstudio/+files/$KXSTUDIO
sudo dpkg -i $KXSTUDIO
rm $KXSTUDIO
sudo apt update

sudo apt update -y
# Audio routing
sudo apt install -y jackd jack-capture jack-mixer jack-tools meterbridge
# JACK control app and patchbay
sudo apt install -y qjackctl
# JACK patchbay
# sudo apt install -y patchage
# Patchbay test app
sudo apt install -y catarina
# JACK patchbay
sudo apt install -y catia
# JACK patchbay + session management.  LADISH front-end.  Advanced version of catia.
sudo apt install -y claudia
# Audio plugin host
sudo apt install -y carla
# Audio signal processing
sudo apt install -y cecilia
# Multitrack guitar tab editor
sudo apt install -y tuxguitar tuxguitar-jack
# Virtual guitar amp
# sudo apt install -y guitarix
# Digital audio workstation
sudo apt install -y ardour
# Mulitrack MIDI sequencer
sudo apt install -y qtractor
# Drum machine and sequencer
sudo apt install -y hydrogen
# Audio editor
sudo apt install -y audacity
# DJ mixer
sudo apt install -y mixx
# Audio production tools
sudo apt install -y cadence
# Music composition with notation
sudo apt install -y rosegarden
# Sampler
sudo apt install -y linuxsampler-all
# Synth
sudo apt install -y din
# Synth
sudo apt install -y spiralsynthmodular

# LV2 Plugins
sudo apt install -y calf-plugins
sudo apt install -y swh-lv2
sudo apt install -y lv2vocoder
sudo apt install -y vocproc
sudo apt install -y mad-lv2
sudo apt install -y caps-lv2
sudo apt install -y zynaddsubfx zynaddsubfx-dssi

# sudo apt install -y libfltk1.3 libfltk1.3-dev libsndfile1 libsndfile1-dev libjack-dev
sudo usermod -a -G audio $USER
