#!/bin/bash
# Проверка параметра что, он содержит только цифры
if [[ $1 = *[[:digit:]]* ]]  # digit - класс символов POSIX
then
  echo "Wrong parameter! Parameter must contain only letters."
  exit 1
else
  echo "$1"
fi
