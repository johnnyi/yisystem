#!/bin/bash
baktime=`date +"%y%m%d%H%M"`
date=`date -d "yesterday" +"%Y%m%d"`
echo $date
LOG=/var/log/rsync_im.log
/usr/bin/rsync -vzrtopg --delete --progress 10.0.0.176::im01.data /var/tmp/_tmp-im01/ --password-file=/etc/rsyncd.pwd
if [ $? != 0 ];then
     echo "im01 data rsync from 10.0.0.176 failed!!! at $baktime" >>$LOG
fi
 echo " im01 rsync at $baktime OK!!!">>$LOG

/usr/bin/rsync -vzrtopg --delete --progress 10.0.0.176::im02.data /var/tmp/_tmp-im02/ --password-file=/etc/rsyncd.pwd
if [ $? != 0 ];then
     echo "im01 data rsync from 10.0.0.176 failed!!! at $baktime" >>$LOG
fi
 echo "im02 rsync at $baktime OK!!!">>$LOG
/bin/chown -R www.www /data/rsync
/bin/chown -R www.www /var/tmp/*

rm -rf /data/rsync/im01/*
rm -rf /data/rsync/im02/*
/bin/cp /var/tmp/_tmp-im01/online_data-$date-*.log /data/rsync/im01/
/bin/cp /var/tmp/_tmp-im02/online_data-$date-*.log /data/rsync/im02/
