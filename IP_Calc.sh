#!/bin/bash

# Неправильно считаются минимальный и максимальный хосты, броадкаст
# Там есть привязка к меске: если кусок макси 0, то и максимальный/минимальный зост на этом месте 255
# А если 255, то 168 например

echo "Введите IP-адрес"
read IP_adress_original_length

IFS="."
j="0"
a="$IP_adress_original_length"

for i in $a
do
 IP_adress_original_length[j]="$i"
 echo ${IP_adress_original_length[j]}
 let "j=j+1"
done
exit




for i in 0 1 2 3
do
 IP_adress_length_3[i]=`printf "%.3d\n" ${IP_adress_original_length[i]}`
done

echo "Введите маску подсети";
read SubNet_Mask_original_length;

IFS="."
j="0"
a="$SubNet_Mask_original_length"

for i in $a
do
 SubNet_Mask_original_length[j]="$i"
 let "j=j+1"
done

for i in 0 1 2 3
do
  SubNet_Mask_length_3[i]=`printf "%.3d\n" ${SubNet_Mask_original_length[i]}`
done

blue=$(tput setaf 4)
brown=$(tput setaf 179)
normal=$(tput sgr0)

declare -A wildmask
for i in 0 1 2 3
do
 z="1"
 for j in 0 1 2 3 4 5 6 7
 do
  wildmask[$i,$j]=`(printf "%.8d\n" $(echo "obase=2; ${SubNet_Mask_length_3[i]}" | bc)) | cut -c$z`
  if [ ${wildmask[$i,$j]} -eq "0" ]
  then
   wildmask[$i,$j]="1"
  else
   wildmask[$i,$j]="0"
  fi
  let "z=z+1"
 done
done

for i in 0 1 2 3
do
 WM[$i]="`echo ${wildmask[$i,0]}${wildmask[$i,1]}${wildmask[$i,2]}${wildmask[$i,3]}\
${wildmask[$i,4]}${wildmask[$i,5]}${wildmask[$i,6]}${wildmask[$i,7]}`"
done

for i in 0 1 2 3
do
 IP_adress_length_8[$i]=`printf "%.8d\n" $(echo "obase=2; ${IP_adress_length_3[i]}" | bc)`
done

for i in 0 1 2 3
do
 SubNet_Mask_length_8[$i]=`printf "%.8d\n" $(echo "obase=2; ${SubNet_Mask_length_3[i]}" | bc)`
done

for i in 0 1 2 3
do
 Network[$i]="$((2#${IP_adress_length_8[$i]} & 2#${SubNet_Mask_length_8[$i]}))"
done

Hosts=1
for i in 0 1 2 3
do
 if [ "${SubNet_Mask_length_3[i]}" -eq "0" ]
 then
  let "(Hosts=$Hosts*256)"
 fi
done
let "(Hosts=$Hosts-2)"

##################################
##########    Ardess    ##########
##################################
printf "%-15s%-0s${blue}.${normal}%-0s${blue}.${normal}%-0s${blue}.${normal}\
%-20s%-0s${brown}.${normal}%-0s${brown}.${normal}%-0s${brown}.${normal}%-0s \n"\
        "Adress:"\
        "${blue}${IP_adress_original_length[0]}${normal}"\
        "${blue}${IP_adress_original_length[1]}${normal}"\
        "${blue}${IP_adress_original_length[2]}${normal}"\
        "${blue}${IP_adress_original_length[3]}${normal}"\
        "${brown}`printf ${IP_adress_length_8[0]}`${normal}"\
        "${brown}`printf ${IP_adress_length_8[1]}`${normal}"\
        "${brown}`printf ${IP_adress_length_8[2]}`${normal}"\
        "${brown}`printf ${IP_adress_length_8[3]}`${normal}"
###################################
##########    Netmask    ##########
###################################
printf "%-15s%-0s${blue}.${normal}%-0s${blue}.${normal}%-0s${blue}.${normal}\
%-22s%-0s${brown}.${normal}%-0s${brown}.${normal}%-0s${brown}.${normal}%-0s \n"\
        "Netmask:"\
        "${blue}${SubNet_Mask_original_length[0]}${normal}"\
        "${blue}${SubNet_Mask_original_length[1]}${normal}"\
        "${blue}${SubNet_Mask_original_length[2]}${normal}"\
        "${blue}${SubNet_Mask_original_length[3]}${normal}"\
        "${brown}`printf ${SubNet_Mask_length_8[0]}`${normal}"\
        "${brown}`printf ${SubNet_Mask_length_8[1]}`${normal}"\
        "${brown}`printf ${SubNet_Mask_length_8[2]}`${normal}"\
        "${brown}`printf ${SubNet_Mask_length_8[3]}`${normal}"
####################################
##########    Wildcard    ##########
####################################
printf "%-15s%-0s${blue}.${normal}%-0s${blue}.${normal}%-0s${blue}.${normal}\
%-20s%-0s${brown}.${normal}%-0s${brown}.${normal}%-0s${brown}.${normal}%-0s \n\n"\
        "Wildcard:"\
        "${blue}`printf \`echo \"ibase=2;${WM[0]}\" | bc\``${normal}"\
        "${blue}`printf \`echo \"ibase=2;${WM[1]}\" | bc\``${normal}"\
        "${blue}`printf \`echo \"ibase=2;${WM[2]}\" | bc\``${normal}"\
        "${blue}`printf \`echo \"ibase=2;${WM[3]}\" | bc\``${normal}"\
        "${brown}${WM[0]}${normal}"\
        "${brown}${WM[1]}${normal}"\
        "${brown}${WM[2]}${normal}"\
        "${brown}${WM[3]}${normal}"
###################################
##########    Network    ##########
###################################
printf "%-15s%-0s${blue}.${normal}%-0s${blue}.${normal}%-0s${blue}.${normal}\
%-22s%-0s${brown}.${normal}%-0s${brown}.${normal}%-0s${brown}.${normal}%-0s \n"\
        "Network:"\
        "${blue}${Network[0]}${normal}"\
        "${blue}${Network[1]}${normal}"\
        "${blue}${Network[2]}${normal}"\
        "${blue}${Network[3]}${normal}"\
        "${brown}`printf "%.8d" \`echo \"obase=2;${Network[0]}\" | bc\``${normal}"\
        "${brown}`printf "%.8d" \`echo \"obase=2;${Network[1]}\" | bc\``${normal}"\
        "${brown}`printf "%.8d" \`echo \"obase=2;${Network[2]}\" | bc\``${normal}"\
        "${brown}`printf "%.8d" \`echo \"obase=2;${Network[3]}\" | bc\``${normal}"
###################################
##########    Hostmin    ##########
###################################
printf "%-15s%-0s${blue}.${normal}%-0s${blue}.${normal}%-0s${blue}.${normal}\
%-22s%-0s${brown}.${normal}%-0s${brown}.${normal}%-0s${brown}.${normal}%-0s \n"\
        "Hostmin:"\
        "${blue}${Network[0]}${normal}"\
        "${blue}${Network[1]}${normal}"\
        "${blue}0${normal}"\
        "${blue}1${normal}"\
        "${brown}`printf "%.8d" \`echo \"obase=2;${IP_adress_original_length[0]}\" | bc\``${normal}"\
        "${brown}`printf "%.8d" \`echo \"obase=2;\"0\"\" | bc\``${normal}"\
        "${brown}`printf "%.8d" \`echo \"obase=2;\"0\"\" | bc\``${normal}"\
        "${brown}`printf "%.8d" \`echo \"obase=2;\"1\"\" | bc\``${normal}"
###################################
##########    Hostmax    ##########
###################################
printf "%-15s%-0s${blue}.${normal}%-0s${blue}.${normal}%-0s${blue}.${normal}\
%-20s%-0s${brown}.${normal}%-0s${brown}.${normal}%-0s${brown}.${normal}%-0s \n"\
        "Hostmax:"\
        "${blue}${Network[0]}${normal}"\
        "${blue}${Network[1]}${normal}"\
        "${blue}255${normal}"\
        "${blue}254${normal}"\
        "${brown}`printf "%.8d" \`echo \"obase=2;${IP_adress_original_length[0]}\" | bc\``${normal}"\
        "${brown}`printf "%.8d" \`echo \"obase=2;${IP_adress_original_length[1]}\" | bc\``${normal}"\
        "${brown}`printf "%.8d" \`echo \"obase=2;\"255\"\" | bc\``${normal}"\
        "${brown}`printf "%.8d" \`echo \"obase=2;\"254\"\" | bc\``${normal}"
#####################################
##########    Broadcast    ##########
#####################################
printf "%-15s%-0s${blue}.${normal}%-0s${blue}.${normal}%-0s${blue}.${normal}\
%-20s%-0s${brown}.${normal}%-0s${brown}.${normal}%-0s${brown}.${normal}%-0s \n"\
        "Broadcast:"\
        "${blue}${Network[0]}${normal}"\
        "${blue}${Network[1]}${normal}"\
        "${blue}255${normal}"\
        "${blue}255${normal}"\
        "${brown}`printf "%.8d" \`echo \"obase=2;${Network[0]}\" | bc\``${normal}"\
        "${brown}`printf "%.8d" \`echo \"obase=2;${Network[1]}\" | bc\``${normal}"\
        "${brown}`printf "%.8d" \`echo \"obase=2;\"255\"\" | bc\``${normal}"\
        "${brown}`printf "%.8d" \`echo \"obase=2;\"255\"\" | bc\``${normal}"
##################################
##########    Ardess    ##########
##################################
printf "%-15s%-0s\n"\
        "Hosts:"\
        "${blue}$Hosts${normal}"
