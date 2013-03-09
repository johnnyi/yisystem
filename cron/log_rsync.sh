#!/bin/bash

baktime=`date +"%y%m%d%H%M"`
LOG=/var/log/log_rsync.log
/usr/bin/rsync -vzrtopg --delete --progress 10.0.0.168::web01_log /data/log/web01_log --password-file=/etc/rsyncd.pwd
if [ $? != 0 ];then
     echo "log  rsync from 10.0.0.168 failed!!! at $baktime" >>$LOG
fi
 echo " log rsync at $baktime OK!!!">>$LOG

