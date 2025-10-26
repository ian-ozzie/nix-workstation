#!/usr/bin/env bash

SOCKET="${XDG_RUNTIME_DIR:-/run/user/$UID}/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.hyprsunset.sock"
INTERVAL=5

send () {
  jq -cn --arg text "$1" --arg class "$2" --arg tooltip "$3" \
    '{ text: $text, class: $class, tooltip: $tooltip }'
}

check_temp () {
  if [[ ! -S "$SOCKET" ]]; then
    send '󰹐' 'error' 'waiting for hyprsunset socket'
    return 0
  fi

  if [[ ! $(nc -U "$SOCKET" -N <<<tempereature) ]]; then
    send '󰹐' 'error' 'hyprsunset socket refused'
    return 0
  fi

  TEMP=$(nc -U "$SOCKET" -N <<<temperature)
  GAMMA=$(nc -U "$SOCKET" -N <<<gamma)
  if [[ "$GAMMA" -lt "100" ]]; then
    send '󱩌' 'active' "active: ${TEMP}k @ ${GAMMA}% gamma"
    return 0
  fi

  if [[ "$TEMP" -lt "6000" ]]; then
    send '󰌵' 'active' "active: ${TEMP}k"
    return 0
  fi

  send '󰌶' 'inactive' 'not active'
  return 0
}

# TODO: change this to even listening if possible in future, rather than polling
while true; do
  check_temp
  sleep $INTERVAL
done
