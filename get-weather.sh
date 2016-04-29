#!/bin/bash
#
# 2016 WeakNet Labs, weaknetlabs@gmail.com
#  Douglas Berdeaux
#
HOMEFILE=$(awk -F: "/$(whoami)/ {print \$6}" /etc/passwd)"/.wt7-weather.config";
if ! [[ -f "$HOMEFILE" ]]; then
 echo "Could not load the configuration file \"$(awk -F: "/$(whoami)/ {print \$6}" /etc/passwd)/.wt7-weather.config\"."
 echo "Running the configuratino tool now."
 weather-config.sh
fi	
ZIP=$(sed -n '5p' $HOMEFILE) # get weather ZIP/ID from config file
if [[ "$ZIP" = "" || "$ZIP" = "#" ]];then # string comparison "="
 echo "Could not determine your location. Starting the weather-config.sh utility."
 weather-config.sh # start the configuration initialization
fi
# Should I just run it for them above? It prompts for the ID.
# TODO I guess.
# Some variables:
CONKYCONF="/etc/conky/conky.conf" # config file for conky
WEATHER=$(curl -s https://www.wunderground.com/weather-forecast/$ZIP|grep -i 'og:title' | \
 sed -re 's/^\s//g' \
 -e 's/.*tent="([^"]+)".*/\1/i' \
 -e 's/&deg;/\xc2\xb0/ig' \
 -e 's/\s//g' \
 -e 's/\|/ /g');
ICON=$(echo $WEATHER|sed 's/.*\s//g');
WEATHER=$(echo $WEATHER | sed 's/\xc2\xb0.*/\xc2\xb0/g'); # drop the weather part
# title: $(curl -s https://www.wunderground.com/weather-forecast/$ZIP|grep -Ei '<title>'|sed -re 's/.*>([^(]+).*/\1/g')
ICON=$(echo $ICON|sed -re 's/(clear|sunny).*/clear.png/ig' \
 -e 's/^(mostly)?(cloud|over).*/cloudy.png/ig' \
 -e 's/.*partly\s?cloudy.*/partly-cloudy.png/ig' \
 -e 's/.*wind.*/wind.png/ig' \
 -e 's/.*snow.*/snow.png/ig' \
 -e 's/.*fog.*/fog.png/ig' \
 -e 's/.*storm.*/storm.png/ig');
# let user know: (DEBUG)
echo "Weather will be displayed as: \${$WEATHER}\${$ICON}"

# This will replace entire line:
LINE="\${image \/usr\/share\/wt7\/wt7-weather\/icons\/$ICON -n -p 0,65 -s 32x32}\${font Prime:size=14}      $WEATHER"
sed -i.conf "35s/.*/$LINE/" $CONKYCONF
killall conky
conky & # fork
