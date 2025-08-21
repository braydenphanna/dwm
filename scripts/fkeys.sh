function mute(){
	~/dwm/scripts/bar.sh

	amixer set Master 1+ toggle

	muted="$(awk '/Left:/ {print $6}' <(amixer sget Master) | tr -d '[]')"
	printf "$muted"
	if [ $muted == "on" ]; then
		light -s sysfs/leds/platform::mute -S 0
	else	
		light -s sysfs/leds/platform::mute -S 100
	fi	
}

function decreaseVolume(){
	~/dwm/scripts/bar.sh

	amixer set Master 1%-
}

function increaseVolume(){
	~/dwm/scripts/bar.sh

	amixer set Master 1%+
}

function decreaseBrightness(){
	~/dwm/scripts/bar.sh

	light -U 1
}

function increaseBrightness(){
	~/dwm/scripts/bar.sh

	light -A 1
}
