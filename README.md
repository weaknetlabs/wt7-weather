# Weakerthan 7 Weather App
<img border="0" src="https://weaknetlabs.com/images/wt7-beta-weather-screenshot.PNG"><br />
Conky display for weather that gets updates from www.wunderground.com
## Install
Run the installer:<br />
<code>root@wt7-elite:~# ./install.sh install</code>

## Config
The configuration file will be in your home directory, ".wt7-weather.config" The daemon updates the conky-config file on line 32. Please see my sample conky-config file. You will need to update the "./get-weather.sh" file at the sed line to change it to a different line:<br />
<code>
sed -i.conf "32s/.*/$LINE/" $CONKYCONF
</code><br />
Change the "32" in the line above to fit your own Conky theme.
## Run app
Simply run the deamon<br />
<code>wt7-weatherd</code>
