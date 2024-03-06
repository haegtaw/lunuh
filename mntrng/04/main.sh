#!/bin/bash

FLAG_COLOR_DEFAULT=0

source ./conf_color.conf
source ./conf_color_def.conf

column1_background=${column1_background:=${default_column1_background}}
column1_font_color=${column1_font_color:=${default_column1_font_color}}
column2_background=${column2_background:=${default_column2_background}}
column2_font_color=${column2_font_color:=${default_column2_font_color}}

# Проверка входных параметров
. ./f_check_param.sh

# Функция в которой устанавливается цвет
. ./f_func_color.sh

# Вывод результата
. ./f_output.sh

exit 0
