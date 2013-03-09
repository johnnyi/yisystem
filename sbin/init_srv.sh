#!/bin/bash
#Author : Yi Xiaohui
#MSN    : yxh_benet@hotmail.com
#QQ     : 398774310

turn_on ()
{
chkconfig --list $1 | grep 3:on || chkconfig $1 on 
service $1 start
}


rpm -q xinetd || yum -y install xinetd
turn_on xinetd

rpm -q ntp || yum -y install ntp
turn_on ntpd

rpm -q sysstat || yum -y install sysstat
turn_on sysstat

#rpm -q net-snmp || yum -y install net-snmp

#[ -f /etc/snmp/snmpd.conf ] && rm -f /etc/snmp/snmpd.conf
#cp ${SVNDIR}/conf/snmpd.conf /etc/snmp/snmpd.conf

#turn_on snmpd

rpm -q rsync || yum -y install rsync
if [ -f /etc/rsyncd.conf ] ; then
		:
	else
		cp ${SVNDIR}/conf/rsyncd.conf /etc
		chkconfig rsync on
		service xinetd reload
fi

selinuxenabled && setsebool -P rsync_disable_trans on
