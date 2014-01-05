#!/bin/bash

xsel="$HOME/Archives/txt/CMD"
cmd=(dmenu -i -b -nb \#1c1c1c -nf \#d7005f -sb \#252525 -fn "-*-terminus-medium-*-*-*-12-*-*-*-*-*-*-*" -p xsel)
out=$(tac $xsel | ${cmd[@]})
xclip -i -loop 1 <<< "$out"
