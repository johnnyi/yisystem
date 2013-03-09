#!/bin/bash
#Author : Yi Xiaohui
#MSN    : yxh_benet@hotmail.com
#QQ     : 398774310

chkconfig portmap off
chkconfig cups off
chkconfig nfslock off
chkconfig apmd off
chkconfig bluetooth off
chkconfig hidd off
chkconfig gpm off
chkconfig ip6tables off
chkconfig pcscd off
chkconfig xfs off
chkconfig netfs off
chkconfig autofs off
chkconfig avahi-daemon off
chkconfig auditd off
chkconfig haldaemon off

service portmap stop
service cups stop
service nfslock stop
service apmd stop
service bluetooth stop
service hidd stop
service gpm stop
service ip6tables stop
service pcscd stop
service xfs stop
service netfs stop
service autofs stop
service avahi-daemon stop
service auditd stop
service haldaemon stop
