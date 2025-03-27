#!/usr/bin/env bash

if [[ $1 == "increase" ]]; then
  TARGET=$(hyprctl getoption -j cursor:zoom_factor | jq .float | awk '{ printf "%4.3f\n", $1 * 1.1 }')
elif [[ $1 == "decrease" ]]; then
  TARGET=$(hyprctl getoption -j cursor:zoom_factor | jq .float | awk '{ printf "%4.3f\n", $1 * 0.9 }')
elif [ -z "$(echo $1 | sed -e's/^[0-9\.]*$//g')" ]; then
  TARGET=$1
else
  TARGET=1
fi

hyprctl keyword cursor:zoom_factor $(echo $TARGET | awk '{ if ( $1 > 1 ) { print $1 } else { print 1 } }')
