#!/bin/bash
if (whiptail --title "Будильник"\
             --yes-button "Выключить" --no-button "Пусть играет"\
             --yesno "Что будем с ним делать?"\
             10 60) then
	pid=`ps ax | grep "/usr/bin/mpg123" | awk 'NR == 2{print$1}'`
	kill "$pid"
else
    :
fi
