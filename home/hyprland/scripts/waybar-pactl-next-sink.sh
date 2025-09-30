CURRENT=$(pactl get-default-sink)
FIRST=
FOUND=
NEXT=

while read -r sink; do
  if [ -z "$FIRST" ]; then
    FIRST=$sink
  fi

  if [ -n "$FOUND" ]; then
    NEXT=$sink
    break
  fi

  if [ "${sink//\"}" == "${CURRENT//\"}" ]; then
    FOUND=true
    continue
  fi
done <<< "$(pactl -f json list sinks | command jq '.[]'.name)"

if [ -z "$NEXT" ]; then
  NEXT=$FIRST
fi

pactl set-default-sink "${NEXT//\"}"
