#!/bin/bash
weather=$(~/i3-weather/weather.py 2483553)

i3status -c ~/.i3/i3status.conf | while :
do
    read line

    dir=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)
    mpd_song=$(mpc current | sed 's?[<>*]?_?g')
    mpd_song=${mpd_song// & / and }
    phone_status=$(ps -ef | grep "indicator-kdeconnect" | grep -v "grep" | wc -l)

if [ "$phone_status" = 1 ]; then
phone_text=$(echo "")
else
phone_text=$(echo " phone n/a.")


    if [ "$mpd_song" != "" ]; then
        mpd_status=$(mpc status  | tail -2 | head -1 | cut -d' ' -f1 | tr -d '[]')
      if [ "$mpd_status" = "playing" ]; then            
            echo -n "  $mpd_song | $line |   $weather |$phone_text" |sed 's?|?//?g'|| exit 1
            continue
	else
        echo -n "  Paused | $line |   $weather |$phone_text" | sed 's?|?//?g'|| exit 1
        continue
fi
fi
fi
echo -n "  Paused | $line |   $weather |$phone_text" | sed 's?|?//?g'|| exit 1
done
