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

str01="HOSTNAME = $HOSTNAME"
str02="TIMEZONE = $TIMEZONE"
str03="USER = $USER"
str04="OS = $OS"
str05="DATE = $DATE"
str06="UPTIME = $UPTIME"
str07="UPTIME_SEC = $UPTIME_SEC"
str08="IP = $IP"
str09="MASK = $MASK"
str10="GATEWAY = $GATEWAY"
str11="RAM_TOTAL = $RAM_TOTAL"
str12="RAM_USED = $RAM_USED"
str13="RAM_FREE = $RAM_FREE"
str14="SPACE_ROOT = $SPACE_ROOT"
str15="SPACE_ROOT_USED = $SPACE_ROOT_USED"
str16="SPACE_ROOT_FREE = $SPACE_ROOT_FREE"

for arg in "$str01" "$str02" "$str03" "$str04" "$str05" "$str06" "$str07"\
  "$str08" "$str09" "$str10" "$str11" "$str12" "$str13" "$str14" "$str15"\
  "$str16"
do
  echo $arg
done

echo

. ./save_log_file.sh

exit 0