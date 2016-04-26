#!/bin/bash
#
# 2016 WeakNet Labs, weaknetlabs@gmail.com
#  Douglas Berdeaux
#
usage () { # display usage
 echo "Usage: ./install.sh (install|uninstall)"
 exit 1;
}
if ! [[ "$1" ]];then
 usage;
fi
# Check if root
if [ "$1" = "install" ];then # install it
 if [ "$(id|awk -F= '{gsub(/\(.*/,"",$2); print $2}')" = "0" ];then
  INSTPATH="/usr/local/bin"
  cp get-weather.sh $INSTPATH
  cp weather-config.sh $INSTPATH
  cp wt7-weatherd $INSTPATH
  # clobber file:
  cat > $(awk -F: "/$(whoami)/ {print \$6}" /etc/passwd)"/.wt7-weather.config" << EOL
#!/bin/bash
#
#
#
#
EOL
 else
  echo "Please run the installer as root, or with sudo."
  exit 1; # failed
 fi
elif [ "$1" = "uninstall" ];then # uninstall it
 rm -rf $INSTPATH/get-weather.sh
 rm -rf $INSTPATH/weather-config.sh
 rm -rf $INSTPATH/wt7-weatherd
 # destroy cruft:
 rm -rf $(awk -F: "/$(whoami)/ {print \$6}" /etc/passwd)"/.wt7-weather.config"
else
 usage; # what did they give me?
fi
