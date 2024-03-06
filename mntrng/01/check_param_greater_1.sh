#!/bin/bash
# Проверка на то, что кол-во парметров больше 1
if [ $# -gt 1 ]
then
    echo "Too much parameters! Need 1 parametr."
    exit 1
fi
