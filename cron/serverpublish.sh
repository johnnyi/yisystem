#!/bin/bash
baktime=`date +"%y%m%d%H%M"`
/usr/local/bin/quitein_stop
sleep 5

cd /opt/backup/server
tar zcf server.$baktime.tar.gz /app/quitein

/usr/bin/rsync -vzrtopg  --exclude='log' --exclude='imd01/data'  --exclude='imd02/data' --delete --progress 10.0.0.173::server01 /app/quitein --password-file=/etc/rsyncd.pwd

sleep 5
/usr/local/bin/quitein_start
