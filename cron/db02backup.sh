#!/bin/bash
DATATIME=`date +"%Y-%m-%d  %H:%M"`
baktime=`date +"%y%m%d"`
bakdir=/mnt/host/mysql/$baktime
dbuser="root"
dbpass="duiduila_admin"
LOG="/var/log/mysql/mysqldump_$baktime.log"
	if [ $UID -ne 0 ]
	then
        alert_and_log "[ERROR] You are not root ... exit"
        exit 1
	fi

        if [ -f "/etc/init.d/functions" ]
        then
        . /etc/init.d/functions
        else
	success () {
        echo -n " [OK]"
	}
        fi

        if [ -d /var/log/mysql ] ;then
        :
        else
         mkdir /var/log/mysql
        fi

       if [ -d $bakdir ];then
        :
       else
        mkdir -p $bakdir
       fi
echo "#-----------------------------BACKUP DB starting...at $DATATIME -----------------------#"
echo "#-----------------------------BACKUP DB starting...at $DATATIME -----------------------#" >>$LOG

cd $bakdir

for dbname in mysql duiduila duiduila_activity duiduila_card ucenter

do
/usr/local/mysql/bin/mysqldump  --flush-logs -u $dbuser -p$dbpass --add-drop-table  $dbname >$dbname.sql
        if [ $? != 0 ];then
                echo "  Database $dbname  bakup Failed!!!" >>$LOG
                echo " Database $dbname bakcup failed!!! " |mail -s "backup failed" johnnyyi@nenxun.com
        else
                echo " Database $dbname Dump Successful!!! "
                success
                echo
                echo " Database $dbname Dump Successful!!!" >>$LOG

        fi

done

cd /mnt/host/mysql/

tar zcf database$baktime.tar.gz $baktime

echo " #-------------------------Mysql Backup Successful!!! at $DATATIME ----------------------- " 
echo " #-------------------------Mysql Backup Successful!!! at $DATATIME ----------------------- " >>$LOG

if [ -d $baktime ];then
        rm -rf $baktime
else
        echo "can't rm the directory...">>$LOG
fi

