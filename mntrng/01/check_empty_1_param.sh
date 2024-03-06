#!/bin/bash
# Проверка на отсутствие первого параметра
if [ -z "$1" ] 
then
  echo "Parameter 1 is empty! Need 1 parametr."
  exit 1
fi
