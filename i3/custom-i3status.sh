#!/bin/bash

i3status -c ~/.i3/i3status.conf | while :
do
    read line

    dir=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)
    mpd_song=$(mpc current)
weather_shit=$(/home/rjacobs/i3-weather/weather.py 2402731)



    if [ "$spotify_status" = "Playing" ] ; then
        echo -n "NP: $spotify_artist - $spotify_song | $line" || exit 
        continue
    elif [ "$mpd_song" != "" ]; then
        mpd_status=$(mpc status | tail -2 | head -1 | cut -d' ' -f1 | tr -d '[]')
        if [ "$mpd_status" = "playing" ]; then            
            echo -n "  $mpd_song | $line |  $weather_shit" || exit 1
            continue
        fi
        echo -n "$line |  $weather_shit" || exit 1
        continue
    fi
    echo -n "$line |  $weather_shit" || exit 1
done
