#/bin/bash


# 2017-03-09
# Author: Stephen Collins
# Description: Broadcast a command to multiple tmux panes
#              Important, make sure the number of panes and IP's agree!

# Tmux initialization
SESSION=0; WINDOW=2; PANE_START=1; PANE_STOP=5

# Build an array of IP addresses
IP[1]="10.2.0.12"; IP[2]="10.2.0.11"; IP[3]="10.2.0.10"; IP[4]="10.2.0.34"; IP[5]="10.2.0.9";
#IP[6]="10.2.0.12"; IP[7]="10.2.0.11"; IP[8]="10.2.0.10"; IP[9]="10.2.0.34"; IP[10]="10.2.0.9";

# Open telnet sessions on the devices
PANE=$PANE_START
for I in `seq 1 ${#IP[@]}`; do
    tmux send-keys -t $SESSION:$WINDOW.$PANE "telnet ${IP[I]}" C-m
    PANE=$((++PANE))
done

# Build an array with commands to send
CMD[1]="pinebelt"; CMD[2]="rtl2302"; CMD[3]="show alarm log"; CMD[4]=" "; CMD[5]=" "

# Send commands to the devices
sleep 1
for I in `seq 1 ${#CMD[@]}`; do
    for PANE in `seq $PANE_START $PANE_STOP`; do
        tmux send-keys -t $SESSION:$WINDOW.$PANE -l "${CMD[I]}"
        tmux send-keys -t $SESSION:$WINDOW.$PANE C-m
    done
    sleep 1
done
exit
