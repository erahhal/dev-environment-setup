#!/bin/bash

export DISPLAY=:0
sleep 2
xrandr --output DVI-I-1 --pos 0x400
sleep 2

# This doesn't seem to work
~/.xmonad/xmonadctl 3
~/.xmonad/xmonadctl 7
~/.xmonad/xmonadctl 3
~/.xmonad/xmonadctl 1
~/.xmonad/xmonadctl 5
~/.xmonad/xmonadctl 1
~/.xmonad/xmonadctl 3
~/.xmonad/xmonadctl 7
~/.xmonad/xmonadctl 3
~/.xmonad/xmonadctl 1
~/.xmonad/xmonadctl 5
~/.xmonad/xmonadctl 1
