#/bin/bash


# 2017-03-09
# Author: Stephen Collins
# Description: Broadcast a command to multiple tmux panes

# Tmux initialization
SESSION=5; WINDOW=0;

# Important: number of panes and IP's must agree!
PANE_START=1; PANE_STOP=3

# Array of IP addresses
IP[1]="10.2.0.9";
IP[2]="10.2.0.10";
IP[3]="10.2.0.11";

# Open telnet sessions on the devices
PANE=$PANE_START
for I in `seq 1 ${#IP[@]}`; do
    tmux send-keys -t $SESSION:$WINDOW.$PANE "telnet ${IP[I]}" C-m
    PANE=$((++PANE))
done

# Array of commands to send
CMD[1]="pinebelt";
CMD[2]="xyzabc";
CMD[3]="show alarm log";
CMD[4]=" ";

# Send commands to the devices
sleep 2
for I in `seq 1 ${#CMD[@]}`; do
    for PANE in `seq $PANE_START $PANE_STOP`; do
        tmux send-keys -t $SESSION:$WINDOW.$PANE -l "${CMD[I]}"
        tmux send-keys -t $SESSION:$WINDOW.$PANE C-m
    done
    sleep 1
done
exit
