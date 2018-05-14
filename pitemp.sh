#!/bin/sh

echo $(sudo /usr/bin/vcgencmd measure_temp | cut -d= -f2)

