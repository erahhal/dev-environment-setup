#!/usr/bin/env python
import os
import subprocess
import sys
import time

def get_res():
    # get resolution
    xr = subprocess.check_output(['xrandr']).decode('utf-8').split()
    pos = xr.index('current')
    return [int(xr[pos+1]), int(xr[pos+3].replace(',', '') )]

if len(sys.argv) < 2:
    print('This script takes one argument - the path to the script to run.')
    sys.exit(1)

command = sys.argv[1]

res1 = get_res()
while True:
    time.sleep(2)
    res2 = get_res()
    if res2 != res1:
        script_path = os.path.dirname(os.path.realpath(__file__))
        command_path = os.path.join(script_path, command)
        subprocess.Popen(['/bin/bash', '-c', command_path])
    res1 = res2
