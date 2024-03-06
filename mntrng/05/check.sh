#!/bin/bash

# Проверка на пустой параметр
if [ -z "$1" ] 
then
  echo "Parameters are empty! Need 1 parametrs."
  exit 1
# Проверка на то что параметров больше 1
# $# - количество параметров переданных скрипту
elif [[ $# -gt 1 ]]
then
  echo "Too much parameters! Need 1 parametrs."
  exit 1
fi
# Проверка на то что 1-ый параметр в конце содержит знак "/"
if [[ ${DIRECTORY: - 1} != "/" ]]
then
  echo "Wrong path! Missing sign in the end \"/\"."
  exit 1
fi
# Проверка существования каталога
if [[ ! -d "$1" ]]
then
  echo "No such directory!"
  exit 1
fi
