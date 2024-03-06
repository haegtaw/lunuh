#!/bin/bash
START=`date +%s.%N`
DIRECTORY=$1

. ./check.sh

TOTALFOL=$(sudo ls $DIRECTORY   -lR | grep ^d | wc -l)

TOP5=`sudo du -hx $DIRECTORY | sort -rh | head -5 # | awk '{ printf "%d - %s, %s\n",NR, $2, $1}'`

TOTALFILES=`sudo find $DIRECTORY -type f | wc -l`

TOTALCONF=`sudo find $DIRECTORY -name '*conf' | wc -l`

TOTALTXT=`sudo find $DIRECTORY -name '*txt' | wc -l`

TOTALEXE=`sudo find $DIRECTIRY -type f -perm -u+rx | wc -l`

TOTALLOG=`sudo find $DIRECTORY -name '*log' | wc -l`

filearch=`sudo find $DIRECTORY -type f -exec du -Sh {} + | sort -rh | head -n 10  | awk ' { print $2 }'`
TOTALARCH=`file $filearch | grep -c archive`

TOTALSYM=`sudo ls -l $DIRECTORY | grep -c ^l`

extension=`sudo find $DIRECTORY -type f -exec du -Sh {} + | sort -rh | head -n 10 | awk -F '.' 'length($NF)<14 {print $NF}'`
TOP10FILES=`sudo find $DIRECTORY -type f -exec du -Sh {} + | sort -rh | head -n 10 | awk '{printf "%d - %s, %s,\n",NR, $2, $1}'`


exefile=`sudo find $DIRECTORY -type f -perm -u+rx -exec du -Sh {} + | sort -rh | head -n 10 | awk '{print $2}'`
if [[ $exefile == "" ]]
then
  MD5=0;
else
  MD5=`sudo md5sum $exefile | awk '{print $1}'`
fi
EXE10=`sudo find $DIRECTORY -type f -executable -exec du -Sh {} + | sort -rh | head -n 10 | awk '{printf "%d - %s, %s,\n",NR, $2, $1}'`



echo "Total number of folders (including all nested ones) = $TOTALFOL"
echo "TOP 5 folders of maximum size arranged in descending order (path and size):"
echo "$TOP5"
echo "Total number of files = $TOTALFILES"
echo "Number of:"
echo "Configuration files (with the .conf extension) = $TOTALCONF"
echo "Text files = $TOTALTXT"
echo "Executable files = $TOTALEXE"
echo "Log files (with the extension .log) = $TOTALLOG"
echo "Archive files = $TOTALARCH"
echo "Symbolic links = $TOTALSYM"
echo "TOP 10 files of maximum size arranged in descending order (path, size and type):"
paste -d' ' <(echo "$TOP10FILES") <(echo "$extension")
echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file):"
paste -d' ' <(echo "$EXE10") <(echo "$MD5")

END=`date +%s.%N`
RUNTIME=$( echo "$END - $START" | bc -l)
printf "Script execution time (in seconds) = %.1f\n" $RUNTIME
