#!/usr/bin/env bash

status=$(playerctl status 2>/dev/null)
if [[ -z $status ]]; then
  exit
fi

if [[ $status == "Stopped" ]]; then
  exit
fi

artist=$(playerctl metadata artist 2>/dev/null)
title=$(playerctl metadata title 2>/dev/null)

if [[ $status == "Playing" ]]; then
  if [[ -z $artist ]]; then
    echo "󰿎 $title"
    exit
  fi

  echo "♫ $artist - $title"
  exit
fi

if [[ -z $artist ]]; then
  echo "$title"
  exit
fi

echo "$artist - $title"
exit
