#!/bin/bash
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink 
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

ps aux | grep [p]ulseaudio | awk '{print $2}' | xargs kill -9
sudo service bluetooth restart
echo "Loading pulse audio bluetooth modules..."
sleep 7
pactl load-module module-switch-on-connect
pactl load-module module-bluetooth-discover
APPLET_LIST_CMD="ps aux | grep [b]lueman-applet | awk '{print \$2}'"
if [ $(eval "$APPLET_LIST_CMD | wc -l") -gt 0 ]; then
        eval "$APPLET_LIST_CMD | xargs kill"
fi
nohup blueman-applet </dev/null >/dev/null 2>&1 &
sleep 5
# This needs to be run a second time for some reason
pactl load-module module-bluetooth-discover
$DIR/a2dp.sh
