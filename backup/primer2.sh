#!/bin/bash

full_path_to_file="./Test_File"


 a="$full_path_to_file"
 
 if [[ "`echo "$full_path_to_file" | cut -c-1`" == "." ]]
 then
  path_to_file=`pwd`
 fi
 
 echo "$path_to_file"
