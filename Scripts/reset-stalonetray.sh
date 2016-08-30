#!/bin/bash

APPLET_LIST_CMD="ps aux | grep [s]talonetray | awk '{print \$2}'"
if [ $(eval "$APPLET_LIST_CMD | wc -l") -gt 0 ]; then
	eval "$APPLET_LIST_CMD | xargs kill"
fi
exit
nohup stalonetray </dev/null >/dev/null 2>&1 &
