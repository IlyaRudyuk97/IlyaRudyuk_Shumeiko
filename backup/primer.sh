#!/bin/bash

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
 
FPTF=$(backup_directory_definition)
#file_name=$(name_definition $FPTF)
echo -e "$FPTF"
