#!/bin/bash

Player=$1

if /usr/bin/zenity --question --text="Будильник сработал. Отключить?" --timeout=42;
then
 pid=`/bin/ps ax | /bin/grep "/usr/bin/$Player" | /usr/bin/awk 'NR == 2{print$1}'`
 /bin/kill "$pid"
 /usr/bin/zenity --info --text="Будильник отключен" --timeout=5
fi
