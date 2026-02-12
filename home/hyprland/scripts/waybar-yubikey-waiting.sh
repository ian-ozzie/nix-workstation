#!/usr/bin/env bash

SOCKET="${XDG_RUNTIME_DIR:-/run/user/$UID}/yubikey-touch-detector.socket"
INTERVAL=5

send () {
  # Defaults to blank, which hides the waybar widget
  TEXT="${1:-}"
  CLASS="${2:-}"
  TOOLTIP="${3:-}"

  jq -cn --arg text "$TEXT" --arg class "$CLASS" --arg tooltip "$TOOLTIP" \
    '{ text: $text, class: $class, tooltip: $tooltip }'
}

while true; do
  if [ ! -e "$SOCKET" ]; then
    send '󱦃  waiting for socket' 'notice'
    while [[ ! -e $SOCKET ]]; do sleep $INTERVAL; done
  fi

  send

  # https://github.com/maximbaz/yubikey-touch-detector#notifierunix_socket
  nc -U "$SOCKET" | while read -r -n5 message; do
    type="${message:0:3}"
    status="${message:4:1}"

    if [[ $status -eq 0 ]]; then
      send
    else
      send "󱦃 ${type}" 'alert' "YubiKey needs a touch, trigger: ${type}"
    fi
  done

  send
  sleep $INTERVAL
done
