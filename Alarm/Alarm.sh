#!/bin/bash

echo "1. Создать будильник"
echo "2. Вывести список существующих будильников"
echo "3. Выйти"

read First_Choise
if [[ "$First_Choise" = "1" ]]
then
 echo "Как назовем будильник?";
 read Alarm_Name;

 crontab -l > current_alarms.txt
 sed -i -e '/#/!d' -i -e 's/^[#]*//' current_alarms.txt
 
 if ! grep "$Alarm_Name" current_alarms.txt
 then
  rm current_alarms.txt 
  echo "На какой день недели?"
  echo "1. Понедельник";
  echo "2. Вторник";
  echo "3. Среда";
  echo "4. Четверг";
  echo "5. Пятница";
  echo "6. Суббота";
  echo "7. Воскресенье";
  echo "8. Вся неделя";
  read Week_Day;
  case $Week_Day in
   1)
    Week_Day="mon"
    ;;
   2)
    Week_Day="tue"
    ;;
   3)
    Week_Day="wed"
    ;;
   4)
    Week_Day="thu"
    ;;
   5)
    Week_Day="fri"
    ;;
   6)
    Week_Day="sat"
    ;;
   7)
    Week_Day="sun"
    ;;
   8)
    Week_Day="*"
    ;;
  esac
 
  echo "На какое время?";
  echo "Часы";
  read Hour;
  echo "Минуты";
  read Minute;
 
  echo "Что будет играть?";
  echo "1. Мелодия 1";
  echo "2. Мелодия 2";
  echo "3. Мелодия 3";
  read Tune ;
  case $Tune in
   1)
    Tune="Мелодия1.mp3"
    ;;
   2)
    Tune="Мелодия2.mp3"
    ;;
   3)
    Tune="Мелодия3.mp3"
    ;;
  esac
 
  echo "Какой плейер будем использовать?";
  echo "1. ""`dpkg -l | grep \"audio player\|MP3 player\|movie player for Unix-like systems\" | awk 'NR==1{print$2}'`";
  echo "2. ""`dpkg -l | grep \"audio player\|MP3 player\|movie player for Unix-like systems\" | awk 'NR==2{print$2}'`";
  echo "3. ""`dpkg -l | grep \"audio player\|MP3 player\|movie player for Unix-like systems\" | awk 'NR==3{print$2}'`";
  echo "4. Другое";
  read Player;
  case $Player in
   1)
    Player="mpg123"
    ;;
   2)
    Player="mpg321"
    ;;
   3)
    Player="mplayer"
    ;;
   4)
    echo "Введите название проигрывателя"
    read Uninstalled_Player
    echo "Нажмите enter для установки"
    echo "sudo apt install $Uninstalled_Player"
    ;;
  esac
 
  (crontab -l | grep . ; echo -e "#""$Alarm_Name") | crontab -
  croncmd1="/usr/bin/$Player /home/ilya/Шумейко/Alarm/$Tune"
  cronjob1="$Minute $Hour * * $Week_Day $croncmd1"
  (crontab -l | grep . ; echo -e "$cronjob1") | crontab -
 
  croncmd2="DISPLAY=:0 /home/ilya/Шумейко/Alarm/killer.sh"
  cronjob2="$Minute $Hour * * $Week_Day $croncmd2"
  (crontab -l | grep . ; echo -e "$cronjob2 $Player") | crontab -
 
  echo "Будильник успешно создан"
 

 else
  rm current_alarms.txt
  
  echo "Будильник с таким названием уже существует. Хотите редактировать?";
  echo "1. Да";
  echo "2. Нет";
  read Edit;
  if [[ "$Edit" = "1" ]]
  then
   echo -e "Параметры существующего будильника $Alarm_Name\n"
  
   crontab -l > current_alarms.txt
   
   Number_Of_String=`sed -n  "/\#$Alarm_Name/=" current_alarms.txt`   
   let "Alarm_String = Number_Of_String+1"
 
   Choised_Alarm_Minute=`cat current_alarms.txt | sed -n "${Alarm_String}p" | cut -c1-2`
   Choised_Alarm_Hour=`cat current_alarms.txt | sed -n "${Alarm_String}p" | cut -c4-5`
   Choised_Alarm_Week_Day=`cat current_alarms.txt | sed -n "${Alarm_String}p" | cut -c11-13`
   Choised_Alarm_Tune=`cat current_alarms.txt | sed -n "${Alarm_String}p" | cut -c63-81`
   Choised_Alarm_Player=`cat current_alarms.txt | sed -n "${Alarm_String}p" | cut -c24-29`
 
   echo -e "Название будильника---------""$Alarm_Name"
   echo -e "День недели-----------------""$Choised_Alarm_Week_Day"
   echo -e "Время-----------------------""$Choised_Alarm_Hour"":""$Choised_Alarm_Minute"
   echo -e "Мелодия---------------------""$Choised_Alarm_Tune"
   echo -e "Используемый плейер---------""$Choised_Alarm_Player"
   echo -e "\nВыберите новые параметры \n"
 
   Number_Of_String=`sed -n "/\#$Alarm_Name/=" current_alarms.txt`
   let "Alarm_String = Number_Of_String+1"
   let "Alarm_Killer = Number_Of_String+2"
   sed -i -e "$Number_Of_String d" -i -e "$Alarm_String d" -i -e "$Alarm_Killer d" -i -e '/^$/d' current_alarms.txt
   crontab current_alarms.txt
   rm current_alarms.txt
 
   echo "На какой день недели?"
   echo "1. Понедельник";
   echo "2. Вторник";
   echo "3. Среда";
   echo "4. Четверг";
   echo "5. Пятница";
   echo "6. Суббота";
   echo "7. Воскресенье";
   echo "8. Вся неделя";
   read Week_Day;
   case $Week_Day in
    1)
     Week_Day="mon"
     ;;
    2)
     Week_Day="tue"
     ;;
    3)
     Week_Day="wed"
     ;;
    4)
     Week_Day="thu"
     ;;
    5)
     Week_Day="fri"
     ;;
    6)
     Week_Day="sat"
     ;;
    7)
     Week_Day="sun"
     ;;
    8)
     Week_Day="*"
     ;;
   esac

   echo "На какое время?";
   echo "Часы";
   read Hour;
   echo "Минуты";
   read Minute;
 
   echo "Что будет играть?";
   echo "1. Мелодия 1";
   echo "2. Мелодия 2";
   echo "3. Мелодия 3";
   read Tune ;
   case $Tune in
    1)
     Tune="Мелодия1.mp3"
     ;;
    2)
     Tune="Мелодия2.mp3"
     ;;
    3)
     Tune="Мелодия3.mp3"
     ;;
   esac


   echo "Какой плейер будем использовать?";
   echo "1. ""`dpkg -l | grep \"audio player\|MP3 player\|movie player for Unix-like systems\" | awk 'NR==1{print$2}'`";
   echo "2. ""`dpkg -l | grep \"audio player\|MP3 player\|movie player for Unix-like systems\" | awk 'NR==2{print$2}'`";
   echo "3. ""`dpkg -l | grep \"audio player\|MP3 player\|movie player for Unix-like systems\" | awk 'NR==3{print$2}'`";
   echo "4. Другое";
   read Player;
   case $Player in
    1)
     Player="mpg123"
     ;;
    2)
     Player="mpg321"
     ;;
    3)
     Player="mplayer"
     ;;
    4)
     echo "Введите название проигрывателя"
     read Uninstalled_Player
     echo "Нажмите enter для установки"
     echo "sudo apt install $Uninstalled_Player"
     ;;
   esac
 
   (crontab -l | grep . ; echo -e "#""$Alarm_Name") | crontab -
   croncmd1="/usr/bin/$Player /home/ilya/Шумейко/Alarm/$Tune"
   cronjob1="$Minute $Hour * * $Week_Day $croncmd1"
   (crontab -l | grep . ; echo -e "$cronjob1\n") | crontab - 
 
   croncmd2="DISPLAY=:0 /home/ilya/Шумейко/Alarm/killer.sh"
   cronjob2="$Minute $Hour * * $Week_Day $croncmd2 $Player"
   (crontab -l | grep . ; echo -e "$cronjob2\n") | crontab - 
 
   echo "Будильник успешно создан"
 
   exit
  else
   if [[ "$Edit" = "2" ]]
   then
    echo "1. Начать сначала";
    echo "2. Выйти";
    read End;
    if [[ "$End" = "1" ]]
    then
    /home/ilya/Шумейко/Alarm/Alarm.sh
    exit
    else
     if [[ "$End" = "2" ]]
     then
      exit
     fi
    fi
   fi
  fi
 fi
fi




















if [[ "$First_Choise" = "2" ]]
then
 crontab -l > current_alarms.txt
 sed -e '/#/!d' -e 's/^[#]*//' current_alarms.txt > List.txt
 if ! [[ -s List.txt ]]
 then
  echo -e "\nНет существующих будильников\n"
  echo "1. Начать сначала"
  echo "2. Выйти"
  read If_No_Alarms
  if [[ "$If_No_Alarms" = "1" ]]
  then
   /home/ilya/Шумейко/Alarm/Alarm.sh
   exit;
  else
   if [[ "$If_No_Alarms" = "2" ]]
   then
    exit
   fi
  fi
 fi
 rm List.txt
 
 crontab -l > current_alarms.txt
 sed -e '/#/!d' -e 's/^[#]*//' current_alarms.txt
 
 echo "Введите название будильника для дальнейших действий"
 read Choised_Alarm_Name
 echo "1. Просмотреть"
 echo "2. Удалить"
 echo "3. Редактировать" 

 read Act
 case $Act in
 1)
  Number_Of_String=`sed -n  "/\#$Choised_Alarm_Name/=" current_alarms.txt`
  let "Alarm_String = Number_Of_String+1"

  Choised_Alarm_Minute=`cat current_alarms.txt | sed -n "${Alarm_String}p" | cut -c1-2`
  Choised_Alarm_Hour=`cat current_alarms.txt | sed -n "${Alarm_String}p" | cut -c4-5`
  Choised_Alarm_Week_Day=`cat current_alarms.txt | sed -n "${Alarm_String}p" | cut -c11-13`
  Choised_Alarm_Tune=`cat current_alarms.txt | sed -n "${Alarm_String}p" | cut -c63-81`
  Choised_Alarm_Player=`cat current_alarms.txt | sed -n "${Alarm_String}p" | cut -c24-30`

  echo -e "\nНазвание будильника---------""$Choised_Alarm_Name"
  echo "День недели-----------------""$Choised_Alarm_Week_Day"
  echo "Время-----------------------""$Choised_Alarm_Hour"":""$Choised_Alarm_Minute"
  echo "Мелодия---------------------""$Choised_Alarm_Tune"
  echo -e "Используемый плейер---------""$Choised_Alarm_Player\n"

  echo "Выберите дальнейшее действие"
  echo "1. Удалить"
  echo "2. Начать сначала"
  echo "3. Выйти"
  read Next_Act
  
  case $Next_Act in
  1)
   Number_Of_String=`sed -n "/\#$Choised_Alarm_Name/=" current_alarms.txt`
   let "Alarm_String = Number_Of_String+1"
   let "Alarm_Killer = Number_Of_String+2"
   sed -i -e "$Number_Of_String d" -i -e "$Alarm_String d" -i -e "$Alarm_Killer d" -i -e '/^$/d' current_alarms.txt
   crontab current_alarms.txt
   rm current_alarms.txt
   echo "Будильник успешно удален"
   ;;
  2)
   /home/ilya/Шумейко/Alarm/Alarm.sh
   exit
   ;;
  3)
   exit
   ;;
  esac
  ;;
2)
 Number_Of_String=`sed -n "/\#$Choised_Alarm_Name/=" current_alarms.txt`
 echo "$Number_Of_String"
 let "Alarm_String = Number_Of_String+1"
 let "Alarm_Killer = Number_Of_String+2"
 sed -i -e "$Number_Of_String d" -i -e "$Alarm_String d" -i -e "$Alarm_Killer d" -i -e '/^$/d' current_alarms.txt
 crontab current_alarms.txt
 rm current_alarms.txt
 echo "Будильник успешно удален"
 ;;
3)
 echo -e "Параметры существующего будильника $_Choised_Alarm_Name\n"
  
 crontab -l > current_alarms.txt
 
 Number_Of_String=`sed -n  "/\#$Choised_Alarm_Name/=" current_alarms.txt`   
 let "Alarm_String = Number_Of_String+2"

 Choised_Alarm_Minute=`cat current_alarms.txt | sed -n "${Alarm_String}p" | cut -c1-2`
 Choised_Alarm_Hour=`cat current_alarms.txt | sed -n "${Alarm_String}p" | cut -c4-5`
 Choised_Alarm_Week_Day=`cat current_alarms.txt | sed -n "${Alarm_String}p" | cut -c11-13`
 Choised_Alarm_Tune=`cat current_alarms.txt | sed -n "${Alarm_String}p" | cut -c63-81`
 Choised_Alarm_Player=`cat current_alarms.txt | sed -n "${Alarm_String}p" | cut -c24-29`

 echo -e "Название будильника---------""$Choised_Alarm_Name"
 echo -e "День недели-----------------""$Choised_Alarm_Week_Day"
 echo -e "Время-----------------------""$Choised_Alarm_Hour"":""$Choised_Alarm_Minute"
 echo -e "Мелодия---------------------""$Choised_Alarm_Tune"
 echo -e "Используемый плейер---------""$Choised_Alarm_Player"
 echo -e "\nВыберите новые параметры \n"

 Number_Of_String=`sed -n "/\#$Choised_Alarm_Name/=" current_alarms.txt`
 let "Alarm_String = Number_Of_String+1"
 let "Alarm_Killer = Number_Of_String+2"
 sed -i -e "$Number_Of_String d" -i -e "$Alarm_String d" -i -e "$Alarm_Killer d" -i -e '/^$/d' current_alarms.txt
 crontab current_alarms.txt
 rm current_alarms.txt

 echo "На какой день недели?"
 echo "1. Понедельник";
 echo "2. Вторник";
 echo "3. Среда";
 echo "4. Четверг";
 echo "5. Пятница";
 echo "6. Суббота";
 echo "7. Воскресенье";
 echo "8. Вся неделя";
 read Week_Day;
 case $Week_Day in
  1)
   Week_Day="mon"
   ;;
  2)
   Week_Day="tue"
   ;;
  3)
   Week_Day="wed"
   ;;
  4)
   Week_Day="thu"
   ;;
  5)
   Week_Day="fri"
   ;;
  6)
   Week_Day="sat"
   ;;
  7)
   Week_Day="sun"
   ;;
  8)
   Week_Day="*"
   ;;
 esac

 echo "На какое время?";
 echo "Часы";
 read Hour;
 echo "Минуты";
 read Minute;

 echo "Что будет играть?";
 echo "1. Мелодия 1";
 echo "2. Мелодия 2";
 echo "3. Мелодия 3";
 read Tune ;
 case $Tune in
  1)
   Tune="Мелодия1.mp3"
   ;;
  2)
   Tune="Мелодия2.mp3"
   ;;
  3)
   Tune="Мелодия3.mp3"
   ;;
 esac


 echo "Какой плейер будем использовать?";
 echo "1. ""`dpkg -l | grep \"audio player\|MP3 player\|movie player for Unix-like systems\" | awk 'NR==1{print$2}'`";
 echo "2. ""`dpkg -l | grep \"audio player\|MP3 player\|movie player for Unix-like systems\" | awk 'NR==2{print$2}'`";
 echo "3. ""`dpkg -l | grep \"audio player\|MP3 player\|movie player for Unix-like systems\" | awk 'NR==3{print$2}'`";
 echo "4. Другое";
 read Player;
 case $Player in
  1)
   Player="mpg123"
   ;;
  2)
   Player="mpg321"
   ;;
  3)
   Player="mplayer"
   ;;
  4)
   echo "Введите название проигрывателя"
   read Uninstalled_Player
   echo "Нажмите enter для установки"
   echo "sudo apt install $Uninstalled_Player"
   ;;
 esac

 (crontab -l | grep . ; echo -e "#""$Choised_Alarm_Name") | crontab -
 croncmd1="/usr/bin/$Player /home/ilya/Шумейко/Alarm/$Tune"
 cronjob1="$Minute $Hour * * $Week_Day $croncmd1"
 (crontab -l | grep . ; echo -e "$cronjob1\n") | crontab - 

 croncmd2="DISPLAY=:0 /home/ilya/Шумейко/Alarm/killer.sh"
 cronjob2="$Minute $Hour * * $Week_Day $croncmd2 $Player"
 (crontab -l | grep . ; echo -e "$cronjob2\n") | crontab - 

 echo "Будильник успешно создан"

 exit
 ;;
esac
fi
















if [[ "$First_Choise" = "3" ]]
then
 exit
fi
