#!/bin/bash
#Author : Yi Xiaohui
#MSN    : yxh_benet@hotmail.com
#QQ     : 398774310
[ -z ${LOCAL} ] && LOCAL=/usr/local

LINK_ENV()
{
echo ""
echo "if [ -f ${LOCAL}/isystem/profile ] ; then"
echo "    . ${LOCAL}/isystem/profile"
echo "fi"
}
if [ -f /etc/profile ] ; then
        grep -q "${LOCAL}/isystem/profile" /etc/profile || LINK_ENV >> /etc/profile
    else
        if [ -f /etc/bashrc ] ; then
                grep -q "${LOCAL}/isystem/profile" /etc/bashrc || LINK_ENV >> /etc/bashrc
        fi
fi


LINK_RC()
{
echo ""
echo "if [ -f ${LOCAL}/isystem/rc.local ] ; then"
echo "    . ${LOCAL}/isystem/rc.local"
echo "fi"
echo ""
grep -q ^exit /etc/rc.local && sed -i 's/^exit 0//g' /etc/rc.local && echo "exit 0" >> /etc/rc.local
}
grep -q "${LOCAL}/isystem/rc.local" /etc/rc.local || LINK_RC >> /etc/rc.local
