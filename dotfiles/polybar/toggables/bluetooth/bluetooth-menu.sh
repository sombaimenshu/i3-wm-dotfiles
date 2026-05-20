#!/bin/bash

bt_toggle() {
    if bluetoothctl show | grep -q "Powered: yes"; then
        bluetoothctl power off
        notify-send "Bluetooth" "Disabled" --icon=bluetooth-disabled
    else
        bluetoothctl power on
        notify-send "Bluetooth" "Enabled" --icon=bluetooth
    fi
}

bt_status() {
    if bluetoothctl show | grep -q "Powered: yes"; then
        # check if any device is connected
        CONNECTED=$(bluetoothctl info 2>/dev/null | grep -c "Connected: yes")
        if [ "$CONNECTED" -gt 0 ]; then
            DEVICE=$(bluetoothctl info 2>/dev/null | grep "Name" | awk '{print $2}')
            echo "󰂱 $DEVICE"   # BT connected
        else
            echo "󰂯"           # BT on, nothing connected
        fi
    else
        echo "󰂲"               # BT off
    fi
}

bt_menu() {
    if command -v rofi-bluetooth &>/dev/null; then
        rofi-bluetooth &
    elif command -v blueman-manager &>/dev/null; then
        blueman-manager &
    else
        notify-send "Bluetooth" "Install rofi-bluetooth or blueman" --icon=dialog-warning
    fi
}

case "$1" in
    toggle) bt_toggle ;;
    status) bt_status ;;
    menu)   bt_menu ;;
    *)      echo "Usage: $0 {menu|toggle|status}" ;;
esac
