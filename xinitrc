xrandr --output HDMI1 --primary --mode 1920x1080 --pos 0x0 --output VGA1 --mode 1280x1024 --pos 1920x56
xkbcomp $DISPLAY - | egrep -v "group . = AltGr;" | xkbcomp - $DISPLAY
exec awesome
