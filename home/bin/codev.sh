#!/bin/bash

nohup xterm -e tmux new "source $HOME/a/.codev/codev_env/bin/activate && $HOME/a/.codev/Codev.py" > /dev/null 2>&1 &
# nota:
# 	'#!/usr/bin/env python3' no Codev.py
#   chmod u+x Codev.py
