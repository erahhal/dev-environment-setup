#!/bin/bash

DIR="$( cd "$( dirname "$0" )" && pwd )"


#-------------------------------------------------------------
# IRSSI
#-------------------------------------------------------------

if [ "$DIR/irssi" != "$(ls -l ~/.irssi | awk '{print $11}')" ]; then
  mv ~/.irssi ~/.irssi.orig
  ln -s $DIR/irssi ~/.irssi
fi
