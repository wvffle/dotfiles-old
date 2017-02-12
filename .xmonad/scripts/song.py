#!/bin/python3

import sys
import gi
gi.require_version('Playerctl', '1.0')
from gi.repository import Playerctl, GLib

player = Playerctl.Player()

sys.stdout.flush()
sys.stdout.write('{0} - {1} ({2})'.format(player.get_artist(), player.get_title(), player.get_album()))
sys.stdout.flush()

#GLib.MainLoop().run()
