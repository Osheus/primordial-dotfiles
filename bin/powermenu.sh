#!/bin/bash

# CMDs
uptime_info=$(uptime -p | sed -e 's/up //g')
host=$(hostnamectl hostname)

# Options
lock=''
reboot=''
shutdown=''

rofi_cmd() {
	rofi -dmenu \
		-p " $USER @ $host" \
		-mesg " Uptime: $uptime_info" \
		-theme ~/.config/rofi/powermenu.rasi
}

run_rofi()  {
	echo -e "$lock\n$reboot\n$shutdown" | rofi_cmd
}

# Execute Command
run_cmd() {	
	if [[ $1 == '--shutdown' ]]; then
		systemctl poweroff
	elif [[ $1 == '--reboot' ]]; then
		systemctl reboot
	elif [[ $1 == '--lock' ]]; then
		hyprlock	
    	else
		exit 0
    	fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $shutdown)
		run_cmd --shutdown
        ;;
    $reboot)
		run_cmd --reboot
        ;;
    $lock)
		run_cmd --lock
        ;;
esac
