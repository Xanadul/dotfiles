#!/usr/bin/env sh
~/.screenlayout/MainLayoutVega56;
lxsession &
dunst &
/usr/bin/emacs --daemon &
touch ~/text.txt
echo $1 >> ~/text.txt
~/.local/bin/XanBackgrounds $1 x11 &
picom --experimental-backend &
#xborders -c ~/.config/xborders/config.json &
echo "End of Autostart"
