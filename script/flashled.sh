
#pass in seconds to flash for
if [ $# -eq 0 ]; then # no args
 nsec=10
else
 nsec=$1
fi

if dmesg|grep -q "TP-Link Archer C7 v2"; then
led=""
fi
if dmesg|grep -q "TP-Link Archer C7 v5"; then
led=""
fi
if dmesg|grep -q "TP-Link Archer A7 v5"; then
led=""
fi
if dmesg|grep -q "Linksys EA8300"; then
led=""
fi
if dmesg|grep -q "COMFAST CF-EW72"; then
led=""
fi
if dmesg|grep -q "Luma WRTQ-329ACN"; then
led=""
fi
if dmesg|grep -q "Wavlink WL-WN531A6"; then
led=/sys/class/leds/blue\:wifi2g
fi

echo none > $led/trigger
for i in $(seq 0 $nsec); do
 echo 1 > $led/brightness
 sleep 1
 echo 0 > $led/brightness
 sleep 1
done

