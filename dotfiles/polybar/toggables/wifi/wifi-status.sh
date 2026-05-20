#!/bin/bash

INTERFACE="wlan0"   # change to your interface

STATE=$(nmcli radio wifi 2>/dev/null)

if [ "$STATE" != "enabled" ]; then
    echo "󰤭 off"
    exit 0
fi

SSID=$(nmcli -t -f active,ssid dev wifi 2>/dev/null \
    | grep '^yes' \
    | cut -d: -f2-)

if [ -n "$SSID" ]; then
    SIGNAL=$(nmcli -t -f active,signal dev wifi 2>/dev/null \
        | grep '^yes' \
        | cut -d: -f2)
    echo " %{F#FF1378} 󰤨 %{F-}${SIGNAL}%"
else
    echo "󰤫 disconnected"
fi
