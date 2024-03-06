#!/bin/bash

HOSTNAME=$(hostname)
TIMEZONE="$(cat /etc/timezone) $(date +"%Z" -u) $(date +"%:::z")"
USER=$(whoami)
OS=$(uname)
DATE=$(date +"%d %B %Y %X")
UPTIME=$(uptime -p)
UPTIME_SEC=$(cat /proc/uptime | awk '{print $1}')
IP=$(hostname -I)
MASK=$(ifconfig $(ip r | grep default | awk '{print $5}') | awk '/netmask / {print $4}')
GATEWAY=$(ip r | grep default | awk '{print $3}')
RAM_TOTAL=$(free | grep -e Mem: -e Память: | awk '{printf "%.3f GB", $2/(1024. * 1024.)}')
RAM_USED=$(free | grep -e Mem: -e Память: | awk '{printf "%.3f GB", $3/(1024. * 1024.)}')
RAM_FREE=$(free | grep -e Mem: -e Память: | awk '{printf "%.3f GB", $4/(1024. * 1024.)}')
SPACE_ROOT=$(df / | grep dev | awk '{printf "%.2f MB", $2/(1024.)}')
SPACE_ROOT_USED=$(df / | grep dev | awk '{printf "%.2f MB", $3/(1024.)}')
SPACE_ROOT_FREE=$(df / | grep dev | awk '{printf "%.2f MB", $4/(1024.)}')

str[1]="HOSTNAME"
str_res[1]="$HOSTNAME"
str[2]="TIMEZONE"
str_res[2]="$TIMEZONE"
str[3]="USER"
str_res[3]="$USER "
str[4]="OS"
str_res[4]="$OS"
str[5]="DATE"
str_res[5]="$DATE"
str[6]="UPTIME"
str_res[6]="$UPTIME"
str[7]="UPTIME_SEC"
str_res[7]="$UPTIME_SEC"
str[8]="IP"
str_res[8]="$IP"
str[9]="MASK"
str_res[9]="$MASK"
str[10]="GATEWAY"
str_res[10]="$GATEWAY"
str[11]="RAM_TOTAL"
str_res[11]="$RAM_TOTAL"
str[12]="RAM_USED"
str_res[12]="$RAM_USED"
str[13]="RAM_FREE"
str_res[13]="$RAM_FREE"
str[14]="SPACE_ROOT"
str_res[14]="$SPACE_ROOT"
str[15]="SPACE_ROOT_USED"
str_res[15]="$SPACE_ROOT_USED"
str[16]="SPACE_ROOT_FREE"
str_res[16]="$SPACE_ROOT_FREE"

for ((i = 1; i < 17; i++))
do
  echo -e "${color1}${str[i]}${color_auto} = ${color2}${str_res[i]}${color_auto}"
done

echo

if [[ $FLAG_COLOR_DEFAULT -eq 0 ]]
then
  echo "Column 1 background = $column1_background (${NAME_COLOR[$column1_background]})"
  echo "Column 1 font color = $column1_font_color (${NAME_COLOR[$column1_font_color]})"
  echo "Column 2 background = $column2_background (${NAME_COLOR[$column2_background]})"
  echo "Column 2 font color = $column2_font_color (${NAME_COLOR[$column2_font_color]})"
else 
  echo "Column 1 background = default (${NAME_COLOR[$default_column1_background]})"
  echo "Column 1 font color = default (${NAME_COLOR[$default_column1_font_color]})"
  echo "Column 2 background = default (${NAME_COLOR[$default_column2_background]})"
  echo "Column 2 font color = default (${NAME_COLOR[$default_column2_font_color]})"
fi
