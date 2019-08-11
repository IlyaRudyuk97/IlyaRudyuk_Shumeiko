#!/bin/bash

function object_definition {
 clear>&2
 echo "1. Ввести путь к объекту, который будет копироваться">&2
 echo "2. Вывести список подключенных накопителей">&2
 read choise
 if [ "$choise" = "1" ]
 then
  clear>&2
  echo "Ведите путь к объекту, который будет копироваться">&2
  read path_to_file_being_copied
 elif [ "$choise" = "2" ]
 then
  clear>&2
  echo "     Список подключенных устройств:">&2
  echo "Путь к устройству           Объем памяти">&2
  df -h | grep "sd" | awk '{print "    "$1"                   "$2}'>&2
  echo "Введите путь до выбранного устройства">&2
  read path_to_file_being_copied
 else
  clear>&2
  echo "Ошибка. Попробуйте снова">&2
  object_definition
 fi
 echo "$path_to_file_being_copied"
 }

function name_definition() {
 IFS='/'
 j="0"
 a="$full_path_to_file"
 
 for i in $a
 do
  Name[$j]="$i"
  let "j=j+1"
 done
 
 let "j=j-1"
 echo ${Name[j]}
 }

function path_definition() {
 IFS='/'
 j="0"
 a="$full_path_to_file"
 
 if [[ "`echo "$full_path_to_file" | cut -c-1`" == "." ]]
 then
  path_to_file=`pwd`
  echo "$path_to_file"
  return
 fi
 
 for i in $a
 do
  Name[$j]="$i"
  let "j=j+1"
 done
 let "j=j-1"
 
 path_to_file="/"${Name[1]}
 i=2
 while [ "$i" -lt "$j" ]
 do
  path_to_file="$path_to_file/${Name[i]}"
  let "i=$i+1"
 done
 echo "$path_to_file"
 }

function type_definition() {
 
 if test -f $full_path_to_file
 then
  Type="Обычный файл"
 fi

 if test -d $full_path_to_file
 then
  Type="Директория"
 fi

 if test -b $full_path_to_file
 then
  Type="Блочное устройство"
 fi

 if test -e $file_name
 then
  if  ! (test -f $full_path_to_file) && \
      ! (test -d $full_path_to_file) && \
      ! (test -b $full_path_to_file)
  then
   echo "Неверный тип файла"
   exit
  fi
 else
  echo "Файл не существует"
  exit
 fi
 echo "$Type"
 }

function backup_directory_definition {
 echo "Введите путь к месту в котором будет создана резервная копия">&2
 read Backup_Directory
 
  if [[ "`echo "$Backup_Directory" | cut -c-1`" == "." ]]
 then
  Backup_Directory=`pwd`
  echo "$Backup_Directory/"
  return
 fi
 }

function backup_time_definition {
 clear>&2
 echo "В какой день недели будет создаваться резервная копия?">&2
 echo "1. Понедельник">&2
 echo "2. Вторник">&2
 echo "3. Среда">&2
 echo "4. Четверг">&2
 echo "5. Пятница">&2
 echo "6. Суббота">&2
 echo "7. Воскресенье">&2
 echo "8. Вся неделя">&2
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
 clear>&2
 echo "В какое время?">&2
 echo "Час">&2
 read Hour;
 echo "Минута">&2
 read Minute;
 }

function backup_creating() {r
 if [ "$file_type" = "Обычный файл" ] || [ "$file_type" = "Директория" ]
 then
  crontab -l > current_backups.txt
  backup_time='$(/bin/date | /usr/bin/cut -c16-20)'
  cmd="/bin/tar -cvzf $Backup_Directory/\"$file_name-$backup_time.tar.gz\" -C $Backup_Directory $file_name"
  full_cmd="$Minute $Hour * * $Week_Day $cmd"
  echo "$full_cmd" >> current_backups.txt
  echo "#$file_name-$Week_Day:$Hour:$Minute" >> current_backups.txt
  crontab current_backups.txt
  #rm current_backups.txt
  echo "Отлично! Все получилось."
  exit
 fi 
 
 if [ "$file_type" = "Блочное устройство" ]
 then
  crontab -l > current_backups.txt
  backup_time='$(/bin/date | /usr/bin/cut -c16-20)'
  cmd="/bin/dd if=$path_to_file_being_copied of=$Backup_Directory/\"$file_name-$backup_time.iso\""
  full_cmd="$Minute $Hour * * $Week_Day $cmd"
  echo "$full_cmd" >> current_backups.txt
  echo "#$file_name-$Week_Day:$Hour:$Minute" >> current_backups.txt
  crontab current_backups.txt
  rm current_backups.txt
  echo "Отлично! Все получилось."
  exit
 fi
 }

clear
echo "1. Создать backup"
echo "2. Вывести список существующих backup'ов"
echo "3. Выйти"
read first_choise

if [[ "$first_choise" = "1" ]]
then
 full_path_to_file=$(object_definition)
 file_name=$(name_definition $full_path_to_file) 
 path_to_file=$(path_definition $full_path_to_file)
 file_type=$(type_definition $full_path_to_file)
 backup_directory_definition
 backup_time_definition
 backup_creating $file_type $Backup_Directory $file_name $Minute $Hour $Week_Day
 
 echo -e "$file_name\n""$path_to_file\n""$file_type"
 exit
fi

if [[ "$First_Choise" = "2" ]]
then
 exit
fi

if [[ "$First_Choise" = "3" ]]
then
 exit
fi
 
 
 
 

