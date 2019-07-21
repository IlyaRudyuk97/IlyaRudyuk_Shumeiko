#!/bin/bash

echo "Введите имя крневой папки";
read RootFolder;
mkdir /home/ilya/$RootFolder;

echo "Введите шаблон названия файла";
read Pattern;

echo "Введите количество папок";
read FolderAmount;

re='^[0-9]+$'
if ! [[ $FolderAmount =~ $re ]] ; then
	echo -e "Здесь нужно вводить чиcло. Попробуйте еще раз \n\n"
	rm -r /home/ilya/$RootFolder
	/home/ilya/Papki.sh
	exit
fi

echo "Введите количество файлов в каждой папке";
read FileAmount;

re='^[0-9]+$'
if ! [[ $FileAmount =~ $re ]] ; then
        echo -e "Здесь нужно вводить чиcло. Попробуйте еще раз \n\n"
        rm -r /home/ilya/$RootFolder
        /home/ilya/Papki.sh
	exit
fi

cd /home/ilya/$RootFolder;

for (( i = 1; i <= $FolderAmount; i++ ))
	do
	mkdir Folder№$i;
	cd /home/ilya/$RootFolder/Folder№$i;
	for ((j=1; j<=$FileAmount; j++))
		do
		touch $Pattern№$j.txt;
		done
	cd ..;
	done
