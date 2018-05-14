#!/bin/bash

# Author:       Stephen Collins
# Date:         2016-04-01
# Description:  Instruct the cow to show system time and hostname.

# Global inits
M=`hostname`
ARG=$1

# Draw the cow
function update_screen(){
   clear
   F=$(mktemp /tmp/moodate.XXXXXX)

   figlet -f small $M >> $F
   cowthink -W 30 -f default "It's" $NOW "...moo" >> $F
   if [[ $ARG = '-l' ]]; then
      cat $F | lolcat -p 10
   else
      cat $F
   fi

   rm -f $F
}

# Main bovine loop
while :
do
   NOW=`date +"%A %b %d %Y %I:%M%p"`
   if [[ $NOW != $THEN ]]; then
      update_screen
   fi
   THEN=$NOW
   sleep 10s
done
