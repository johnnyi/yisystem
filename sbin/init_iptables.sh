#!/bin/bash
#Author : Yi Xiaohui
#MSN    : yxh_benet@hotmail.com
#QQ     : 398774310
# TODO    : init the iptables firewall

############## init iptables #################

echo '*filter' >/etc/sysconfig/iptables
echo ':INPUT ACCEPT [0:0]' >>/etc/sysconfig/iptables
echo ':FORWARD ACCEPT [0:0]' >>/etc/sysconfig/iptables
echo ':OUTPUT ACCEPT [0:0]' >>/etc/sysconfig/iptables
echo ':NX-Firewall-1-INPUT - [0:0]' >>/etc/sysconfig/iptables
echo '-A INPUT -j NX-Firewall-1-INPUT' >>/etc/sysconfig/iptables
echo '-A FORWARD -j NX-Firewall-1-INPUT' >>/etc/sysconfig/iptables
echo '-A NX-Firewall-1-INPUT -i lo -j ACCEPT' >>/etc/sysconfig/iptables
echo '-A NX-Firewall-1-INPUT -p icmp -m icmp --icmp-type any -j ACCEPT' >>/etc/sysconfig/iptables
echo '-A NX-Firewall-1-INPUT -p esp -j ACCEPT' >>/etc/sysconfig/iptables
echo '-A NX-Firewall-1-INPUT -p ah -j ACCEPT' >>/etc/sysconfig/iptables
echo '-A NX-Firewall-1-INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT' >>/etc/sysconfig/iptables
echo '-A NX-Firewall-1-INPUT -p tcp -m tcp --dport 80 -j ACCEPT' >>/etc/sysconfig/iptables
echo '-A NX-Firewall-1-INPUT -s 10.0.1.0/255.255.255.0  -j ACCEPT' >>/etc/sysconfig/iptables
echo '-A NX-Firewall-1-INPUT -p tcp -m tcp --dport 22   -j ACCEPT' >>/etc/sysconfig/iptables
echo '-A NX-Firewall-1-INPUT -s 114.80.119.0/255.255.255.0 -p tcp -m tcp --dport 22   -j ACCEPT' >>/etc/sysconfig/iptables
echo '-A NX-Firewall-1-INPUT -s 210.22.175.2/32 -p tcp -m tcp --dport 22   -j ACCEPT' >>/etc/sysconfig/iptables
echo '-A NX-Firewall-1-INPUT -s 114.80.119.0/255.255.255.0 -p tcp -m tcp --dport 10050   -j ACCEPT' >>/etc/sysconfig/iptables
echo '-A NX-Firewall-1-INPUT -j REJECT --reject-with icmp-host-prohibited' >>/etc/sysconfig/iptables
echo 'COMMIT' >>/etc/sysconfig/iptables

/etc/init.d/iptables restart
/sbin/chkconfig iptables on

