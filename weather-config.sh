#!/bin/bash
#
# 2016 WeakNet Labs, weaknetlabs@gmail.com
#  Douglas Berdeaux
#
INPUT=$(yad --form --field="Weather Underground ID: " --display=$DISPLAY --window-icon=/root/.wt7/images/icons/shield-small-icon.png --center --image=/root/.wt7/images/icons/shield-small-icon.png --title="Weakerthan Linux 7 Elite")
INPUT=$(echo $INPUT|sed -re 's/\|$//g')
FILE=$(awk -F: "/$(whoami)/ {print \$6}" /etc/passwd)"/.wt7-weather.config" # I'm damn good.
if ! [[ -f "$FILE" ]]; then # It didn't exist
 touch $FILE;
 cat > $FILE << EOL
#!/bin/bash
#
#
#
#
EOL
fi
sed -ire "5s/.*/$INPUT/g" $FILE # update the config file.
# run the get-weather.sh code:
get-weather.sh
