#!/bin/bash

xclip -o | 
sed -r '2~1d;s/(^\s+|\s+$)//g;s/%/%25/g;s/#/%23/g;s/\$/%24/g;s/&/%26/g;s/\+/%2B/;s/,/%2C/g;s/:/%3A/g;s/;/%3B/g;s/=/%3D/g;s/\?/%3F/g;s/@/%40/g;s/\s/+/g' |
awk '{print "http://www.google.ru/search?hl=ru&q=" $1}' | 
xargs qutebrowser
