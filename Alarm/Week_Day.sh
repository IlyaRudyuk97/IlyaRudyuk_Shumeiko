#!/bin/bash
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
  Week_Day="mon";;
 2)
  Week_Day="tue";;
 3)
  Week_Day="wed";;
 4)
  Week_Day="thu";;
 5)
  Week_Day="fri";;
 6)
  Week_Day="sat";;
 7)
  Week_Day="sun";;
 8)
  Week_Day="*";;
esac
