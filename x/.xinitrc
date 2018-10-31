setxkbmap dk
xinput set-prop 10 "libinput Natural Scrolling Enabled" 1
xinput set-prop 10 "libinput Accel Speed" 0.5
xinput set-prop 11 "libinput Natural Scrolling Enabled" 1
xinput set-prop 11 "libinput Accel Speed" 0.5
xinput set-prop 12 "libinput Natural Scrolling Enabled" 1
xinput set-prop 12 "libinput Accel Speed" 0.5
source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh
sh -c 'xrandr --output HDMI-0 --mode 1920x1080 --rate 60.00 --output DVI-I-1 --mode 1920x1080 --rate 60.00 --right-of HDMI-0'
screenrotator &
awesome
