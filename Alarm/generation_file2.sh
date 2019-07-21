#!/bin/bash
Alarm_Name="1";
Player="mpg123";
Tune="Мелодия1.mp3"
Minute="09";
Hour="13";
Week_Day="tue";

rm /home/ilya/Шумейко/Alarm/Created_Alarms/$Alarm_Name;
touch /home/ilya/Шумейко/Alarm/Created_Alarms/$Alarm_Name;
chmod +x /home/ilya/Шумейко/Alarm/Created_Alarms/$Alarm_Name;

echo -e '#!/bin/bash' >> /home/ilya/Шумейко/Alarm/Created_Alarms/$Alarm_Name;

croncmd1="/usr/bin/$Player /home/ilya/Шумейко/Alarm/$Tune"
echo -e 'croncmd1=''"'"$croncmd1"'"'>> /home/ilya/Шумейко/Alarm/Created_Alarms/$Alarm_Name;
cronjob1="$Minute $Hour * * $Week_Day$croncmd"
echo -e 'cronjob1=''"'"$cronjob1" '$croncmd1''"' >> /home/ilya/Шумейко/Alarm/Created_Alarms/$Alarm_Name;
echo -e '( crontab -l | grep -v -F "$croncmd1" ; echo "$cronjob1" ) | crontab -' >> /home/ilya/Шумейко/Alarm/Created_Alarms/$Alarm_Name;

echo -e "\n" >> /home/ilya/Шумейко/Alarm/Created_Alarms/$Alarm_Name;

croncmd2="DISPLAY=:0 /home/ilya/Шумейко/Alarm/zenity.sh"
echo -e 'croncmd2=''"'"$croncmd2"'"' >> /home/ilya/Шумейко/Alarm/Created_Alarms/$Alarm_Name;
cronjob2="$Minute $Hour * * $Week_Day$croncmd"
echo -e 'cronjob2=''"'"$cronjob2" '$croncmd2''"' >> /home/ilya/Шумейко/Alarm/Created_Alarms/$Alarm_Name;
echo -e '( crontab -l | grep -v -F "$croncmd2" ; echo "$cronjob2" ) | crontab -' >> /home/ilya/Шумейко/Alarm/Created_Alarms/$Alarm_Name;

chmod +x /home/ilya/Шумейко/Alarm/Created_Alarms/$Alarm_Name;
sh /home/ilya/Шумейко/Alarm/Created_Alarms/$Alarm_Name;
