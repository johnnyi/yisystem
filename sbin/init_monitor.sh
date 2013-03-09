#!/bin/bash
# Author  : Yi XiaoHui
# MSN     : yxh_benet@hotmail.com
# QQ      : 398774310
# E-Mail  : yxhbenet@vip.qq.com

export CONF=/usr/local/yisystem/conf
HOST=`hostname|tail`

[ -z ${LOCAL} ] && LOCAL=/usr/local
SRV=http://source.holdlinux.com/soft/linux/zabbix/zabbix-2.0.1.tar.gz

wget -c -P /usr/local/src ${SRV}

filename=`basename ${SRV}`
dirname=`echo ${filename} | sed 's/.tar.gz//g'`

[ -d /usr/local/src/${dirname} ] && rm -rf /usr/local/src/${dirname}
tar zxvf /usr/local/src/${filename} -C /usr/local/src

cd /usr/local/src/${dirname}

./configure --prefix=/usr/local/zabbix --enable-agent

make install

mkdir /etc/zabbix
/bin/sed -i "s/Hostname\=/Hostname\=$HOST/g" $CONF/zabbix_agentd.conf
cp $CONF/zabbix_agentd.conf /etc/zabbix
cp $CONF/zabbix_agentd /etc/init.d/
/usr/sbin/useradd -s /sbin/nologin zabbix
/sbin/chkconfig --add zabbix_agentd
/sbin/chkconfig zabbix_agentd on
/bin/chmod +x /etc/init.d/zabbix_agentd 
/etc/init.d/zabbix_agentd start
