#!/bin/sh
baktime=`date +"%y%m%d"`
        bakdir=/mnt/host/$baktime
        mkdir -p $bakdir

cd /data/httpd/
ls| xargs -i ls -ld /data/httpd/{} | awk '{print $3, $9}' | while read user documentroot; do
        bname=`basename $documentroot`
        cd  /data/httpd/$bname
        backname=$bname.$baktime
        /bin/tar zcvf $bakdir/$backname.tar.gz *
done
#/bin/cp -rf $bakdir /opt/backup
