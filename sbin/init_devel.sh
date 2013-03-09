#!/bin/bash
# Author  : Yi XiaoHui
# MSN     : yxh_benet@hotmail.com
# QQ      : 398774310
# E-Mail  : yxhbenet@vip.qq.com

export CONF=/usr/local/yisystem/conf
SU_CONFIG=/etc/pam.d/su	


cp -f $CONF/ld.so.conf /etc
/sbin/ldconfig
rpm --quiet -q gcc || yum -y groupinstall Development\ Tools

cat >>/etc/security/limits.conf<<eof
* soft noproc 65535
* hard noproc 65535
* soft nofile 65535
* hard nofile 65535
eof

cat >>/etc/sysctl.conf<<eof
fs.file-max=65535
eof

if grep -q "\#auth.*required.*pam_wheel.so.*use_uid" ${SU_CONFIG}; then

          /bin/sed -i 's/^#auth.*required.*pam_wheel.so.*use_uid/auth            required        pam_wheel.so use_uid/g' ${SU_CONFIG}
fi

