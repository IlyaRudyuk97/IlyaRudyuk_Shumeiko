#!/bin/bash
echo -e '#!/bin/bash' >> /home/ilya/Шумейко/Alarm/Created_Alarms/Test; #Поменять Тест2;
echo -e 'croncmd=''"/usr/bin/mpg123 /home/ilya/Шумейко/Alarm/Мелодия1.mp3"' >> /home/ilya/Шумейко/Alarm/Created_Alarms/Test; #Поменять Тест2;
echo -e 'cronjob=''"* * * * * $croncmd"' >> /home/ilya/Шумейко/Alarm/Created_Alarms/Test; #Поменять Тест2;
echo -e '( crontab -l | grep -v -F "$croncmd" ; echo "$cronjob" ) | crontab -' >> /home/ilya/Шумейко/Alarm/Created_Alarms/Test; #Поменять Тест2;
echo -e '\n' >> /home/ilya/Шумейко/Alarm/Created_Alarms/Test;

echo -e 'croncmd2=''"DISPLAY=:0 /home/ilya/Шумейко//Alarm/zenity.sh"' >> /home/ilya/Шумейко/Alarm/Created_Alarms/Test; #Поменять Тест2;
echo -e 'cronjob2=''"* * * * * $croncmd2"' >> /home/ilya/Шумейко/Alarm/Created_Alarms/Test; #Поменять Тест2;
echo -e '( crontab -l | grep -v -F "$croncmd2" ; echo "$cronjob2" ) | crontab -' >> /home/ilya/Шумейко/Alarm/Created_Alarms/Test; #Поменять Тес$

chmod +x /home/ilya/Шумейко/Alarm/Created_Alarms/Test
sh /home/ilya/Шумейко/Alarm/Created_Alarms/Test
