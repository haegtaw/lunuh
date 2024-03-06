#!/bin/bash

# Проверка на пустой параметр
if [ -z "$1" ] 
then
  echo "Parameters are empty! Need 4 parametrs."
  exit 1
# Проверка на то что параметров больше 4
# $# - количество параметров переданных скрипту
elif [[ $# -gt 4 ]]
then
  echo "Too much parameters! Need 4 parametrs."
  exit 1
# Проверка на то что параметров меньше 4
elif [[ $# -lt 4 ]]
then
  echo "Too few parameters! Need 4 parametrs."
  exit 1
fi

# Проверка параметров что, они содержат только цифры
# $@- перечисление каждого параметра скрипта (параметры по отдельности)
for arg in $@
do 
  if [[ $arg != *[[:digit:]]* ]]  # digit - класс символов POSIX
  then
    echo "Wrong parameter! All parameters must be digits."
    exit 1
  fi
done

# Проверка параметров что, они содержат только цифры от 0 до 6
# $@- перечисление каждого параметра скрипта (параметры по отдельности)
for arg in $@
do 
  if [[ ($arg -gt 6) || ($arg -lt 0) ]]
  then
    echo "Wrong color number! All parameters must be digits from 0 to 6."
    exit 1
  fi
done

# Проверка параметров: у первой пары параметров не совпадают
# значения и у второй пары тоже, иначе на фоне не будет видно символов
# $@- перечисление каждого параметра скрипта (параметры по отдельности)
for arg in $@
do 
  if [[ (($1 -eq $2) && ($1 -ne 0)) || (($3 -eq $4) && ($3 -ne 0)) ]]
  then
    echo "Text and background color match!"
    exit 1
  fi
done
