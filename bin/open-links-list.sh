#!/bin/bash
if [ "$#" -ne 1 ]; then
   echo "Illegal number of parameters"
fi
for line in `cat $1`; do firefox -new-tab "$line" & 2>/dev/null; sleep 1; done
