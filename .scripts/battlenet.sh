battle_net_count=$(ps -ax -o comm | grep -ci battle\.net\.exe)
xfconf-query --channel=xfwm4 --property=/general/use_compositing --set=false
/usr/share/playonlinux/playonlinux --run "Battle.Net" %F
until [ $BATTLE_NET_COUNT -eq 0 ]
do
  sleep 1
  BATTLE_NET_COUNT=$(ps -ax -o comm | grep -ci battle\.net\.exe)
done
xfconf-query --channel=xfwm4 --property=/general/use_compositing --set=true
