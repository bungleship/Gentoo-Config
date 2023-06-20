xmodmap -e "pointer = 3 2 1"
gammastep -l 34:-118 & exec dbus-launch --sh-syntax --exit-with-session xmonad
