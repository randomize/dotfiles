#!/bin/bash

rm -f /tmp/mentioned.txt
rm -f /tmp/locals.txt

cat ~/dots/nfo/paks.txt | sed "s/\/\/.*//;/^\s*$/d;/:/d;/=/d;s/\s*//;s/.*\///;s/ *//g" | sort > /tmp/mentioned.txt
yay -Qe | sed -e "s/.*\///g" | sed -e "s/ .*//" | sort > /tmp/locals.txt

sleep 1

#meld /tmp/locals.txt /tmp/mentioned.txt >/dev/null 2>&1 &
nvim -d /tmp/locals.txt /tmp/mentioned.txt
