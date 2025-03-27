#!/usr/bin/env bash

SOCKET="${XDG_RUNTIME_DIR:-/run/user/$UID}/yubikey-touch-detector.socket"
INTERVAL=5

send () {
  jq -cn --arg text "$1" --arg class "$2" --arg tooltip "$3" '{ text: $text, tooltip: $tooltip, class: $class }'
}

while true; do
  if [ ! -e "$SOCKET" ]; then
    send '󱦃  waiting for socket' 'notice'
    while [ ! -e "$SOCKET" ]; do sleep $INTERVAL; done
  fi

  send

  nc -U $SOCKET | while read -r -n5 message; do
    type="${message:0:3}"
    status="${message:4:1}"

    if [ $status -eq 0 ]; then
      send
    else
      send "󱦃 ${type}" 'alert' "YubiKey needs a touch, trigger: ${type}"
    fi
  done

  send
  sleep $INTERVAL
done
