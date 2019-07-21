#!/bin/bash
#!/usr/bin/bc -q

echo -e "Выберите математическую операцию";
echo -e "1. Вычисление факториала";
echo -e "2. Умножение";
echo -e "3. Деление";
echo -e "4. Сложение";
echo -e "5. Вычитание \n";
read Operation;

re='^[0-9]+$'
   if ! [[ $Operation =~ $re ]] ;
then
echo -e "Здесь нужно вводить чиcло. Попробуйте еще раз \n\n"
/home/ilya/Шумейко/Calc.sh
exit
fi

if["$Operation" - lt "1"]||["$Operation" - gt "5"]
    then echo -e "\nВведена неверная операция. Попробуйте еще раз \n";
/home / ilya / Шумейко/Calc.sh;
exit;
fi


if [[ "$Operation" != "1" ]]
    then
    echo -e "\nВедите первое число";
read a;
re='^[0-9]+$'
   if ! [[ $a =~ $re ]]
       then
       echo -e "Здесь нужно вводить чиcло. Попробуйте еще раз \n\n"
       /home/ilya/Calc.sh
       exit
       fi

       echo -e "Введите второе число";
read b;
re='^[0-9]+$'
   if ! [[ $b =~ $re ]]
       then
       echo -e "Здесь нужно вводить чиcло. Попробуйте еще раз \n\n"
       /home/ilya/Calc
       exit
       fi

       else
           echo -e "\nВедите число"
           read a;
fi

case $Operation in
    1)
    Rezult=1;

    if [ "$a" -eq "0" ]
    then
    echo -e "Факториал " $a " = "
    echo $Rezult;
    echo -e "\nНажмите 1 Чтобы продолжить и любую другую клавишу чтобы закончить";
    read END;
case $END in
        1)
        /home/ilya/Calc.sh
        exit;;
        *)
        exit;;
        esac

        else
            for ((i=1; i<=$a; i++))
                do
                    let "Rezult = i*Rezult"
                    done
                    echo "Факториал " $a " = "
                    echo $Rezult;
                    echo -e "\nНажмите 1 Чтобы продолжить и любую другую клавишу чтобы закончить"
                    read END;
                case $END in
                        1)
                        /home/ilya/Calc.sh
                        exit;;
                        *)
                        exit;;
                        esac

                        fi;;
                        2)
                        let "Rezult = a*b"
                        echo -e "Произведение чисел " $a " и " $b " равно "
                        echo $Rezult;
                        echo -e "\nНажмите 1 Чтобы продолжить и любую другую клавишу чтобы закончить"
                        read END;
                    case $END in
                            1)
                            /home/ilya/Calc.sh
                            exit;;
                            *)
                            exit;;
                            esac;;

                            3)
                            let "Rezult = a/b"
                            echo -e "Результат деления " $a " на " $b " равен "
                            Rezult=$(awk "BEGIN {printf \"%.3f\",${a}/${b}}")
                                   echo "$Rezult"
                                   echo -e "\nНажмите 1 Чтобы продолжить и любую другую клавишу чтобы закончить"
                                   read END;
                        case $END in
                                1)
                                /home/ilya/Calc.sh
                                exit;;
                                *)
                                exit;;
                                esac;;

                                4)
                                let "Rezult = a+b"
                                echo -e "Сложение чисел " $a " и " $b " равно "
                                echo $Rezult ;
                                echo -e "\nНажмите 1 Чтобы продолжить и любую другую клавишу чтобы закончить"
                                read END;
                            case $END in
                                    1)
                                    /home/ilya/Calc.sh
                                    exit;;
                                    *)
                                    exit;;
                                    esac;;

                                    5)
                                    let "Rezult = a-b"
                                    echo -e "\nРазность чисел " $a " и " $b " равна "
                                    Rezult=$(awk "BEGIN {printf \"%.3f\",${a}-${b}}")
                                           echo "$Rezult"
                                           echo -e "Нажмите 1 Чтобы продолжить и любую другую клавишу чтобы закончить"
                                           read END;
                                case $END in
                                        1)
                                        /home/ilya/Calc.sh
                                        exit;;
                                        *)
                                        exit;;
                                        esac;;
                                        *)
                                        echo -e "\nВведена неверная операция. Попробуйте еще раз"
                                        /home/ilya/Calc.sh
                                        exit;;

                                        esac
