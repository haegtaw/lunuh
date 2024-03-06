#!/bin/bash

no='0'
white='37'
red='31'
green='32'
blue='36'
purple='35'
black='30'

# Массив кодов цветовых решений 
COLOR=(
    $no
    $white
    $red
    $green
    $blue
    $purple
    $black
)

function color {
    echo "\033[$((${COLOR[$1]} + 10))m\033[${COLOR[$2]}m"
}

color1=$(color $1 $2)
color2=$(color $3 $4)
color_auto=$(color 0 0)
