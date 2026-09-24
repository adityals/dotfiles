#!/usr/bin/env bash

FOCUSED_WORKSPACE="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused)}"

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set $NAME label.color=0xff979fec
else
    sketchybar --set $NAME label.color=0x50979fec
fi
