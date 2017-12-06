local awful = require("awful")

awful.spawn("sh /home/fred/.config/polybar/launch.sh")
awful.spawn("albert")
awful.spawn("feh --bg-scale /home/fred/wallpaper.jpg")
awful.spawn("copyq")
awful.spawn("xrdb /home/fred/.Xresources")
awful.spawn("compton")
