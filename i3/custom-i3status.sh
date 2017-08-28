#!/bin/bash
weather=$(~/i3-weather/weather.py 2402731)

i3status -c ~/.i3/i3status.conf | while :
do
    read line

    dir=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)
    mpd_song=$(mpc current)
    mpd_song=${mpd_song// & / and }


    if [ "$mpd_song" != "" ]; then
        mpd_status=$(mpc status | tail -2 | head -1 | cut -d' ' -f1 | tr -d '[]')
	if ["$mpd_status" = "volume:"*]; then
	 mpd_status=$(mpc status | tail -1 | head -1 | cut -d' ' -f1 | tr -d '[]')
      if [ "$mpd_status" = "playing" ]; then            
            echo -n "  $mpd_song | $line |  $weather" || exit 1
            continue
	else
        echo -n "  Paused | $line |  $weather" || exit 1
        continue
fi
fi
fi
echo -n "  Paused | $line |  $weather" || exit 1
done
