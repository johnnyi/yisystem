#!/bin/bash
#Author : Yi Xiaohui
#MSN    : yxh_benet@hotmail.com
#QQ     : 398774310
# TODO    : block ipv6 module & init ttys

# block ipv6 module

[ -f /etc/modprobe.d/blacklist ] && grep -q "blacklist ipv6" /etc/modprobe.d/blacklist || echo "blacklist ipv6" >> /etc/modprobe.d/blacklist

##################################################################################
# inittab 
sed -i 's/^3/#3/' /etc/inittab
sed -i 's/^4/#4/' /etc/inittab
sed -i 's/^5/#5/' /etc/inittab
sed -i 's/^6/#6/' /etc/inittab
sed -i 's/ca/#ca/' /etc/inittab

kill -HUP 1

