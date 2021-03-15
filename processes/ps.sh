#!/bin/bash

IFS=" "

function list_processes {
  for pid in $*
   do
     procpid=/proc/$pid
     if [[ -e $procpid/environ && -e $procpid/stat ]]; then
      time=`awk -v ticks="$(getconf CLK_TCK)" '{print strftime ("%M:%S", ($14+$15)/ticks)}' $procpid/stat`

      # Memory Locks
      locked=`grep VmFlags $procpid/smaps | grep lo`

      #STAT

      stats=`awk '{ printf $3; \
      if ($19<0) {printf "<" } else if ($19>0) {printf "N"}; \
      if ($6 == $1) {printf "s"}; \
      if ($20>1) {printf "l"}}' $procpid/stat; \
      [[ -n $locked ]] && printf "L"; \
      awk '{ if ($8!=-1) { printf "+" }}' $procpid/stat`

      # Command line options

      cmdline=`awk '{ print $1 }' $procpid/cmdline | sed 's/\x0/ /g'`
      [[ -z $cmdline ]] && cmdline=`strings -s' ' $procpid/stat | awk '{ printf $2 }' | sed 's/(/[/; s/)/]/'`

      # TTY
      qq=`ls -l $procpid/fd/ | grep -E '\/dev\/tty|pts' | cut -d\/ -f3,4 | uniq`
      tty=`awk '{ if ($7 == 0) {printf "?"} else { printf "'"$qq"'" }}' $procpid/stat`

    fi
    printf  '%7d %-7s %-12s %s %-10s\n' "$pid" "$tty" "$stats" "$time" "$cmdline"
  done
}
ALLPIDS=`ls /proc | grep -P ^[0-9] | sort -n | xargs`
printf  '%7s %-7s %-12s %s %-10s\n' "PID" "TTY" "STAT" "TIME" "COMMAND"
list_processes $ALLPIDS
