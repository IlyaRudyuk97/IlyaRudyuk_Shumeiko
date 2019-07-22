#!/bin/bash

echo "1. Создать backup"
echo "2. Вывести список существующих backup'ов"
echo "3. Выйти"
read First_Choise

############################
# ОПРЕДЕЛЕНИЕ ТИПА ОБЪЕКТА #
############################

if [[ "$First_Choise" = "1" ]]
then
 echo "Введите путь к объекту, который будет копироваться"
 read File_Being_Copied

 if test -f $File_Being_Copied
 then
  Type="Обычный файл"
 fi

 if test -d $File_Being_Copied
 then
  Type="Директория"
 fi

 if test -b $File_Being_Copied
 then
  Type="Блочное устройство"
 fi

 if test -e $File_Being_Copied
 then
  if  ! test -f $File_Being_Copied && ! test -d $File_Being_Copied && ! test -b $File_Being_Copied
  then
   echo "Неверный тип файла"
   exit
  fi
 else
  echo "Файл не существует"
  exit
 fi

fi

#######################################
# ОПРЕДЕЛЕНИЕ МЕСТА СОЗДАНИЯ BACKUP'А #
#######################################

echo "Введите путь к месту в котором будет создана резервная копия"
read Backup_Directody

############################################
# ЕСЛИ ОБЪЕКТ - ПРОСТОЙ ФАЙЛ ИЛИ ДИРЕКТОРИЯ#
############################################

if [[ "$Type" = "Обычный файл" ]] | [[ "$Type" = "Директория" ]]
then
 
fi



echo "$Type"

#if [[ "$First_Choise" = "2" ]]
#then

#fi

if [[ "$First_Choise" = "3" ]]
then
 exit
fi
