#!/bin/sh

brctl addbr br0
ip addr flush dev eth0
brctl addif br0 eth0
tunctl -t tap0
brctl addif br0 tap0
ifconfig eth0 up
ifconfig tap0 up
ifconfig br0 up

cp /etc/udhcpd.conf /etc/udhcpd.conf_default

echo -e "start           172.25.0.101\n\
end             172.25.0.101\n\
interface       br0\n\
opt     dns     8.8.8.8 8.8.4.4\n\
option  subnet  255.255.255.0\n\
opt     router  172.25.0.1\n\
option  lease   864000" > /etc/udhcpd.conf

udhcpd -I 1.2.3.4 -f &

qemu-system-x86_64 \
    -m 256 \
    -hda /routeros/chr-6.47.1.vdi \
    -device e1000,netdev=mynet0 \
    -netdev tap,id=mynet0,ifname=tap0,script=no,downscript=no
