#!/bin/bash
#Author : Yi Xiaohui
#MSN    : yxh_benet@hotmail.com
#QQ     : 398774310
echo $SVNDIR

grep -q SELINUX=disabled /etc/sysconfig/selinux || sed -i '/^SELINUX=enforcing/aSELINUX=disabled' /etc/sysconfig/selinux
sed -i 's/^SELINUX=enforcing/#SELINUX=enforcing/g' /etc/sysconfig/selinux
grep -q SELINUX=disabled /etc/selinux/config || sed -i '/^SELINUX=enforcing/aSELINUX=disabled' /etc/selinux/config
sed -i 's/^SELINUX=enforcing/#SELINUX=enforcing/g' /etc/selinux/config
