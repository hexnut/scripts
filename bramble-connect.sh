#/bin/bash

# Created: 2018-03-15
# Author: Stephen Collins
# Description: Create a tmux session to connect a 4 node raspberry pi bramble.

SESSION=bramble
PANES=$1

# Default value of 4 PANES
if [ -z $PANES ]; then
   PANES=4
fi

# Create tmux session
tmux new-session -d -s $SESSION

# Send login to initial pane
tmux send-keys "ssh pi@pi0" C-m

# Create additional panes as requested, up to 4 total
if [ $PANES -ge 2 ]; then
     tmux split-window -h
     tmux select-pane -t 1
     tmux send-keys "ssh pi@pi1" C-m
fi
if [ $PANES -ge 3 ]; then
     tmux split-window -v -t 0
     tmux select-pane -t 2
     tmux send-keys "ssh pi@pi2" C-m
fi
if [ $PANES -ge 4 ]; then
     tmux split-window -v -t 1
     tmux select-pane -t 3
     tmux send-keys "ssh pi@pi3" C-m
fi

# Select pane 0 and attach the session
tmux select-pane -t 0
tmux -2 attach-session -t $SESSION
