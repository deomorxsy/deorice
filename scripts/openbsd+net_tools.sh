#!/bin/sh

# get kernel state
sysctl

# check device action at boot
dmesg | egrep '^(cd|wd|sd|fd). at'

# check mounted devices
mount



disklabel -p g /dev/wd0c

bioctl -c C -l /dev/wd0a softraid0
