#!/bin/bash

color_str=(
    $column1_background
    $column1_font_color
    $column2_background
    $column2_font_color
)

# Проверка на то что параметры отсутствуют
# $# - количество параметров переданных скрипту
if [[ $# -gt 0 ]]
then
  echo "Too much parameters! The script must be run without parameters. Set default colors."
  FLAG_COLOR_DEFAULT=1
  column1_background=${default_column1_background}
  column1_font_color=${default_column1_font_color}
  column2_background=${default_column2_background}
  column2_font_color=${default_column2_font_color}
fi

# Проверка параметров что, они содержат только цифры
# $@- перечисление каждого параметра скрипта (параметры по отдельности)
for i in "${!color_str[@]}"
do 
  if [[ ${color_str[$i]} != *[[:digit:]]* ]]  # digit - класс символов POSIX
  then
    echo "Wrong parameters! All parameters must be digits. Set default colors."
    FLAG_COLOR_DEFAULT=1
    column1_background=${default_column1_background}
    column1_font_color=${default_column1_font_color}
    column2_background=${default_column2_background}
    column2_font_color=${default_column2_font_color}
  fi
done

# Проверка параметров что, они содержат только цифры от 0 до 6
# $@- перечисление каждого параметра скрипта (параметры по отдельности)
for i in "${!color_str[@]}"
do 
  if [[ (${color_str[$i]} -gt 6) || (${color_str[$i]} -lt 0) ]]
  then
    echo "Wrong color number! All parameters must be digits from 0 to 6. Set default colors."
    FLAG_COLOR_DEFAULT=1
    column1_background=${default_column1_background}
    column1_font_color=${default_column1_font_color}
    column2_background=${default_column2_background}
    column2_font_color=${default_column2_font_color}
  fi
done

# Проверка параметров: у первой пары параметров не совпадают
# значения и у второй пары тоже, иначе на фоне не будет видно символов
# $@- перечисление каждого параметра скрипта (параметры по отдельности)
for i in "${!color_str[@]}"
do 
  if [[ (($column1_background -eq $column1_font_color) && ($column1_background -ne 0))\
  || (($column2_background -eq $column2_font_color) && ($column2_background -ne 0)) ]]
  then
    echo "Text and background color match. Set default colors."
    FLAG_COLOR_DEFAULT=1
    column1_background=${default_column1_background}
    column1_font_color=${default_column1_font_color}
    column2_background=${default_column2_background}
    column2_font_color=${default_column2_font_color}
  fi
done