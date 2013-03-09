#!/bin/bash
day=`date +%Y%m%d`
time=`date +%H:%M`
lasttime=`date --date="-1  minute" +%H:%M`
echo $lasttime 
#lasttime=$1
DST=/data/log/nginx/web01.kj.quitein.com-access.log
echo $DST
line=10000

if [ -f $DST ] ; then
    echo "#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#"
    echo "#@@@@@@@@@@   TIME  : $lasttime    @@@@@@@@@@@@@@@@@@#"
    echo "#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#"
    echo "#-----------TOP 10 IP----------------------------#" 

    tail -$line $DST |grep $lasttime |awk '{print $1}' |sort -n|awk '{print $0}'|uniq -c |sort -n |uniq -u |tail
   
    echo "#-----------TOP 10 GET FILE----------------------#" 

    tail -$line $DST |grep $lasttime|awk '{print $7}'|sort -n|awk '{print $0}' |uniq -c |sort -n |uniq -u |tail 
   # echo "#-----------TOP 10 DOMAIN NAME-------------------#"
   # tail -$line $DST |grep $lasttime|awk '{print $1}' |sort -n |awk '{print $0}'| uniq -c |sort -n |tail 
    echo "#-----------TOP 10 ADDRESS-----------------------#"   
    tail -$line $DST |grep $lasttime|awk '{print $11}' |sort -n |awk '{print $0}'| uniq -c |sort -n |tail  
fi
