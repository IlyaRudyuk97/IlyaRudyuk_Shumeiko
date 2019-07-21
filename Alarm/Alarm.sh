#!/bin/bash

echo "1. Создать будильник"
echo "2. Вывести список существующих будильников"
echo "3. Выйти"

read First_Choise
case $First_Choise in
 1)
  echo "Как назовем будильник?";
  read Alarm_Name;

  if ! [ -f[[ "$End" = "1" ]] /home/ilya/Шумейко/Alarm/Created_Alarms/$Alarm_Name ]
  then
   touch /home/ilya/Шумейко/Alarm/Created_Alarms/$Alarm_Name;
  else
   echo "Будильник с таким названием уже существует. Хотите редактировать?";
   echo "1. Да";
   echo "2. Нет";
   read Edit;
   if [[ "$Edit" = "1" ]]
   then
   echo -e "Параметры существующего будильника $Alarm_Name\n"
   cat /home/ilya/Шумейко/Alarm/Created_Alarms/$Alarm_Name
   echo -e "Выберите новые параметры \n"

   Choised_Alarm_Minute=`sed '1!D' /home/ilya/Шумейко/Alarm/Created_Alarms/Config_$Alarm_Name`
   Choised_Alarm_Hour=`sed '2!D' /home/ilya/Шумейко/Alarm/Created_Alarms/Config_$Alarm_Name`
   Choised_Alarm_Week_Day=`sed '3!D' /home/ilya/Шумейко/Alarm/Created_Alarms/Config_$Alarm_Name`
   Choised_Alarm_Player=`sed '4!D' /home/ilya/Шумейко/Alarm/Created_Alarms/Config_$Alarm_Name`
   Choised_Alarm_Tune=`sed '5!D' /home/ilya/Шумейко/Alarm/Created_Alarms/Config_$Alarm_Name`

   sed -i "/$Alarm_Name/d" /home/ilya/Шумейко/Alarm/Created_Alarms/List

   crontab -l  >> /home/ilya/Шумейко/Alarm/Created_Alarms/current_alarms.txt
   sed -i "/$Choised_Alarm_Minute\ $Choised_Alarm_Hour\ \*\ \*\ $Choised_Alarm_Week_Day\ \/usr\/bin\/$Choised_Alarm_Player\ \/home\/ilya\/Шумейко\/Alarm\/$Choised_Alarm_Tune/d" /home/ilya/Шумейко/Alarm/Created_Alarms/current_alarms.txt
   crontab /home/ilya/Шумейко/Alarm/Created_Alarms/current_alarms.txt
   rm /home/ilya/Шумейко/Alarm/Created_Alarms/current_alarms.txt

   crontab -l  >> /home/ilya/Шумейко/Alarm/Created_Alarms/current_alarms.txt
   sed -i "/$Choised_Alarm_Minute\ $Choised_Alarm_Hour\ \*\ \*\ $Choised_Alarm_Week_Day\ DISPLAY=/d" /home/ilya/Шумейко/Alarm/Created_Alarms/current_alarms.txt
   crontab /home/ilya/Шумейко/Alarm/Created_Alarms/current_alarms.txt
   rm /home/ilya/Шумейко/Alarm/Created_Alarms/current_alarms.txt

   rm /home/ilya/Шумейко/Alarm/Created_Alarms/$Alarm_Name
   rm /home/ilya/Шумейко/Alarm/Created_Alarms/Config_$Alarm_Name

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

   echo "$Minute" >> /home/ilya/Шумейко/Alarm/Created_Alarms/Config_$Alarm_Name
   echo "$Hour" >> /home/ilya/Шумейко/Alarm/Created_Alarms/Config_$Alarm_Name
   echo "$Week_Day" >> /home/ilya/Шумейко/Alarm/Created_Alarms/Config_$Alarm_Name
   echo "$Player" >> /home/ilya/Шумейко/Alarm/Created_Alarms/Config_$Alarm_Name
   echo "$Tune" >> /home/ilya/Шумейко/Alarm/Created_Alarms/Config_$Alarm_Name

    croncmd1="/usr/bin/$Player /home/ilya/Шумейко/Alarm/$Tune"
    cronjob1="$Minute $Hour * * $Week_Day $croncmd1"
    (crontab -l | grep . ; echo -e "$cronjob1\n") | crontab - 

    croncmd2="DISPLAY=:0 /home/ilya/Шумейко/Alarm/zenity.sh"
    cronjob2="$Minute $Hour * * $Week_Day $croncmd2 $Player"
    (crontab -l | grep . ; echo -e "$cronjob2\n") | crontab - 

   echo "Будильник успешно создан"

   touch /home/ilya/Шумейко/Alarm/Created_Alarms/List
   echo -e "$Alarm_Name" >> /home/ilya/Шумейко/Alarm/Created_Alarms/List

   echo -e "Название будильника---------""$Alarm_Name" >> /home/ilya/Шумейко/Alarm/Created_Alarms/$Alarm_Name
   echo -e "День неели------------------""$Week_Day" >> /home/ilya/Шумейко/Alarm/Created_Alarms/$Alarm_Name
   echo -e "Время-----------------------""$Hour:$Minute" >> /home/ilya/Шумейко/Alarm/Created_Alarms/$Alarm_Name
   echo -e "Мелодия---------------------""$Tune" >> /home/ilya/Шумейко/Alarm/Created_Alarms/$Alarm_Name
   echo -e "Используемый плейер---------""$Player\n" >> /home/ilya/Шумейко/Alarm/Created_Alarms/$Alarm_Name
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

  echo "$Minute" >> /home/ilya/Шумейко/Alarm/Created_Alarms/Config_$Alarm_Name
  echo "$Hour" >> /home/ilya/Шумейко/Alarm/Created_Alarms/Config_$Alarm_Name
  echo "$Week_Day" >> /home/ilya/Шумейко/Alarm/Created_Alarms/Config_$Alarm_Name
  echo "$Player" >> /home/ilya/Шумейко/Alarm/Created_Alarms/Config_$Alarm_Name
  echo "$Tune" >> /home/ilya/Шумейко/Alarm/Created_Alarms/Config_$Alarm_Name

  croncmd1="/usr/bin/$Player /home/ilya/Шумейко/Alarm/$Tune"
  cronjob1="$Minute $Hour * * $Week_Day $croncmd1"
  (crontab -l | grep . ; echo -e "$cronjob1") | crontab -

  croncmd2="DISPLAY=:0 /home/ilya/Шумейко/Alarm/zenity.sh"
  cronjob2="$Minute $Hour * * $Week_Day $croncmd2"
  (crontab -l | grep . ; echo -e "$cronjob2 $Player") | crontab -

  echo "Будильник успешно создан"

  touch /home/ilya/Шумейко/Alarm/Created_Alarms/List
  sed -i "/$Alarm_Name/d" /home/ilya/Шумейко/Alarm/Created_Alarms/List
  echo -e "$Alarm_Name" >> /home/ilya/Шумейко/Alarm/Created_Alarms/List

  echo -e "Название будильника---------""$Alarm_Name" >> /home/ilya/Шумейко/Alarm/Created_Alarms/$Alarm_Name
  echo -e "День неели------------------""$Week_Day" >> /home/ilya/Шумейко/Alarm/Created_Alarms/$Alarm_Name
  echo -e "Время-----------------------""$Hour:$Minute" >> /home/ilya/Шумейко/Alarm/Created_Alarms/$Alarm_Name
  echo -e "Мелодия---------------------""$Tune" >> /home/ilya/Шумейко/Alarm/Created_Alarms/$Alarm_Name
  echo -e "Используемый плейер---------""$Player\n" >> /home/ilya/Шумейко/Alarm/Created_Alarms/$Alarm_Name
;;
2)
 if ! [[ -s /home/ilya/Шумейко/Alarm/Created_Alarms/List ]]
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
 cat /home/ilya/Шумейко/Alarm/Created_Alarms/List
 echo "Введите название будильника для дальнейших действий"
 read Choised_Alarm_Name
 echo "1. Просмотреть"
 echo "2. Удалить"
 read Act
 case $Act in
 1)
  cat /home/ilya/Шумейко/Alarm/Created_Alarms/$Choised_Alarm_Name
  echo "Выберите дальнейшее действие"
  echo "1. Удалить"
  echo "2. Начать сначала"
  echo "3. Выйти"
  read Next_Act
  case $Next_Act in
  1)
   Choised_Alarm_Minute=`sed '1!D' /home/ilya/Шумейко/Alarm/Created_Alarms/Config_$Choised_Alarm_Name`
   Choised_Alarm_Hour=`sed '2!D' /home/ilya/Шумейко/Alarm/Created_Alarms/Config_$Choised_Alarm_Name`
   Choised_Alarm_Week_Day=`sed '3!D' /home/ilya/Шумейко/Alarm/Created_Alarms/Config_$Choised_Alarm_Name`
   Choised_Alarm_Player=`sed '4!D' /home/ilya/Шумейко/Alarm/Created_Alarms/Config_$Choised_Alarm_Name`
   Choised_Alarm_Tune=`sed '5!D' /home/ilya/Шумейко/Alarm/Created_Alarms/Config_$Choised_Alarm_Name`

   sed -i "/$Choised_Alarm_Name/d" /home/ilya/Шумейко/Alarm/Created_Alarms/List

   crontab -l  >> /home/ilya/Шумейко/Alarm/Created_Alarms/current_alarms.txt
   sed -i "/$Choised_Alarm_Minute\ $Choised_Alarm_Hour\ \*\ \*\ $Choised_Alarm_Week_Day\ \/usr\/bin\/$Choised_Alarm_Player\ \/home\/ilya\/Шумейко\/Alarm\/$Choised_Alarm_Tune/d" /home/ilya/Шумейко/Alarm/Created_Alarms/current_alarms.txt
   crontab /home/ilya/Шумейко/Alarm/Created_Alarms/current_alarms.txt
   rm /home/ilya/Шумейко/Alarm/Created_Alarms/current_alarms.txt

   crontab -l  >> /home/ilya/Шумейко/Alarm/Created_Alarms/current_alarms.txt
   sed -i "/$Choised_Alarm_Minute\ $Choised_Alarm_Hour\ \*\ \*\ $Choised_Alarm_Week_Day\ DISPLAY=/d" /home/ilya/Шумейко/Alarm/Created_Alarms/current_alarms.txt
   crontab /home/ilya/Шумейко/Alarm/Created_Alarms/current_alarms.txt
   rm /home/ilya/Шумейко/Alarm/Created_Alarms/current_alarms.txt

   rm /home/ilya/Шумейко/Alarm/Created_Alarms/$Choised_Alarm_Name
   rm /home/ilya/Шумейко/Alarm/Created_Alarms/Config_$Choised_Alarm_Name

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
  Choised_Alarm_Minute=`sed '1!D' /home/ilya/Шумейко/Alarm/Created_Alarms/Config_$Choised_Alarm_Name`
  Choised_Alarm_Hour=`sed '2!D' /home/ilya/Шумейко/Alarm/Created_Alarms/Config_$Choised_Alarm_Name`
  Choised_Alarm_Week_Day=`sed '3!D' /home/ilya/Шумейко/Alarm/Created_Alarms/Config_$Choised_Alarm_Name`
  Choised_Alarm_Player=`sed '4!D' /home/ilya/Шумейко/Alarm/Created_Alarms/Config_$Choised_Alarm_Name`
  Choised_Alarm_Tune=`sed '5!D' /home/ilya/Шумейко/Alarm/Created_Alarms/Config_$Choised_Alarm_Name`

  sed -i "/$Choised_Alarm_Name/d" /home/ilya/Шумейко/Alarm/Created_Alarms/List

  crontab -l  >> /home/ilya/Шумейко/Alarm/Created_Alarms/current_alarms.txt
  sed -i "/$Choised_Alarm_Minute\ $Choised_Alarm_Hour\ \*\ \*\ $Choised_Alarm_Week_Day\ \/usr\/bin\/$Choised_Alarm_Player\ \/home\/ilya\/Шумейко\/Alarm\/$Choised_Alarm_Tune/d" /home/ilya/Шумейко/Alarm/Created_Alarms/current_alarms.txt
  crontab /home/ilya/Шумейко/Alarm/Created_Alarms/current_alarms.txt
  rm /home/ilya/Шумейко/Alarm/Created_Alarms/current_alarms.txt

  crontab -l  >> /home/ilya/Шумейко/Alarm/Created_Alarms/current_alarms.txt
  sed -i "/$Choised_Alarm_Minute\ $Choised_Alarm_Hour\ \*\ \*\ $Choised_Alarm_Week_Day\ DISPLAY=/d" /home/ilya/Шумейко/Alarm/Created_Alarms/current_alarms.txt
  crontab /home/ilya/Шумейко/Alarm/Created_Alarms/current_alarms.txt
  rm /home/ilya/Шумейко/Alarm/Created_Alarms/current_alarms.txt

  rm /home/ilya/Шумейко/Alarm/Created_Alarms/$Choised_Alarm_Name
  rm /home/ilya/Шумейко/Alarm/Created_Alarms/Config_$Choised_Alarm_Name

  echo "Будильник успешно удален"
  ;;
  esac
  ;;
3)
 exit
 ;;
esac
