#!/bin/sh

cpu=`cat /sys/class/thermal/thermal_zone0/temp`
echo -n "CPU: "
echo "scale=1;$cpu/1000" | bc

echo "GPU:" $(sudo /usr/bin/vcgencmd measure_temp | cut -d= -f2)

