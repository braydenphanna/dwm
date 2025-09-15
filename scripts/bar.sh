white=#FCFCFC
red=#E63C1A
green=#88CF8B
orange=#F7A639

wifi(){
	case "$(cat /sys/class/net/wlan0/operstate 2>/dev/null)" in
	up) printf " connected" ;;
	down) printf " not connected" ;;
	esac
}

volume(){
	muted="$(awk '/Left:/ {print $6}' <(amixer sget Master) | tr -d '[]')"
	vol="$(awk -F"[][]" '/Left:/ { print $2 }' <(amixer sget Master) |tr -d '%')"
	if [ $muted == "on" ]; then
		if [ $vol -gt 66 ]; then
			printf " $vol"
		else 
			if [ $vol -gt 32 ]; then
				printf " $vol"
			else 
				printf " $vol"
			fi
		fi
	else
		printf " $vol"		
	fi	
}

brightness(){
	bright=$(light)  
    	if (( $(echo "$bright > 49" | bc) )); then
        	printf " %.0f\n" "$bright"  
	else
        	printf " %.0f\n" "$bright" 
	fi
}

battery(){
	printf "^c$white^ "
	for num in 0 1; do
		capacity="$(cat /sys/class/power_supply/BAT$num/capacity) "
		charging="$(cat /sys/class/power_supply/AC/subsystem/BAT$num/status)"
		if [ $charging == "Charging" ]; then
			printf "^c$orange^$capacity"
		else
			if [ $charging == "Discharging" ]; then
				if [ $capacity -gt 20 ]; then
					printf "^c$green^$capacity"
				else
					printf "^c$red^$capacity"
				fi
			else
				printf "$capacity"
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

