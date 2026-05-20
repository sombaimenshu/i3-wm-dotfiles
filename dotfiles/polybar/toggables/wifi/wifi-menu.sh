#!/bin/bash

INTERFACE="wlan0"   # change to your interface (run: ip link)

wifi_toggle() {
    STATE=$(nmcli radio wifi)
    if [ "$STATE" = "enabled" ]; then
        nmcli radio wifi off
        notify-send "WiFi" "Disabled" --icon=network-wireless-disabled
    else
        nmcli radio wifi on
        notify-send "WiFi" "Enabled" --icon=network-wireless
    fi
}

wifi_menu() {
    nmcli dev wifi rescan 2>/dev/null

    NETWORK=$(nmcli -f IN-USE,SSID,SIGNAL,SECURITY dev wifi list 2>/dev/null \
        | tail -n +2 \
        | awk '{
            in_use = ($1 == "*") ? "* " : "  "
            $1=""
            ssid=""
            for(i=2; i<=NF-2; i++) ssid = ssid (i>2 ? " " : "") $i
            signal = $(NF-1)
            security = $NF
            printf "%s%-30s signal:%-4s %s\n", in_use, ssid, signal, security
          }' \
        | rofi -dmenu -p "WiFi" -i -no-custom )

    [ -z "$NETWORK" ] && exit 0

    SSID=$(echo "$NETWORK" | sed 's/^[* ]*//' | awk '{
        for(i=1; i<=NF; i++) {
            if ($i ~ /^signal:/) break
            printf "%s%s", (i>1?" ":""), $i
        }
    }')

    [ -z "$SSID" ] && exit 0

    if nmcli -g NAME con show | grep -qxF "$SSID"; then
        nmcli con up id "$SSID" && \
            notify-send "WiFi" "Connected to $SSID" --icon=network-wireless
    else
        PASS=$(rofi -dmenu -p "Password for '$SSID'" -password -lines 0)
        [ -z "$PASS" ] && exit 0
        nmcli dev wifi connect "$SSID" password "$PASS" && \
            notify-send "WiFi" "Connected to $SSID" --icon=network-wireless || \
            notify-send "WiFi" "Failed to connect to $SSID" --icon=dialog-error
    fi
}

case "$1" in
    toggle) wifi_toggle ;;
    menu)   wifi_menu ;;
    *)      echo "Usage: $0 {menu|toggle}" ;;
esac
