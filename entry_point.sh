#!/bin/ash

GEOMETRY="${SCREEN_WIDTH}x${SCREEN_HEIGHT}x${SCREEN_DEPTH}"
Xvfb :99 -screen 0 $GEOMETRY &
export DISPLAY=:99

rfagent -a 0.0.0.0 -p 1471
