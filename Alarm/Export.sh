#!/bin/bash
croncmd="/home/me/myfunction myargs > /home/me/myfunction.log 2>&1"
cronjob="0 */15 * * * $croncmd"
cat <(fgrep -i -v "$croncmd" <(crontab -l)) <(echo "$cronjob") | crontab -
