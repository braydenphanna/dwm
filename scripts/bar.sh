white=#FCFCFC
red=#E63C1A
green=#88CF8B
orange=#F7A639

wifi(){
	case "$(cat /sys/class/net/wlan0/operstate 2>/dev/null)" in
	up) printf " connected" ;;
	down) printf " disconnected" ;;
	esac
}

volume(){
	printf " $(awk -F"[][]" '/Left:/ { print $2 }' <(amixer sget Master) |tr -d '%')"
}

brightness(){
	printf "󰃞 %.0f" "$(light)"
}

battery(){
	printf "^c$white^ "
	for num in 0 1; do
		capacity="$(cat /sys/class/power_supply/BAT$num/capacity) "
		charging="$(cat /sys/class/power_supply/AC/subsystem/BAT$num/power_now)"
		if [ $charging -eq 1 ]; then
			printf "^c$orange^$capacity"
		else
			if [ $capacity -lt 21 ]; then
				printf "^c$red^$capacity"
			else
				printf "^c$green^$capacity"
			fi
		fi
	done
}
clock(){
	printf "^c$white^󰥔 $(date '+%-I:%M')"
}

function runInBackground(){
while true; do
	sleep 1 && xsetroot -name " $(volume) $(brightness) $(wifi) $(battery)$(clock) "
done
}

xsetroot -name " $(volume) $(brightness) $(wifi) $(battery)$(clock) "

