#!/bin/python3

import sys
import gi
gi.require_version('Playerctl', '1.0')
from gi.repository import Playerctl, GLib

player = Playerctl.Player()

try:
    sys.stdout.write('{0} - {1} ({2})'.format(player.get_artist(), player.get_title(), player.get_album()))
except:
    sys.stdout.write('no music')
