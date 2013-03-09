#!/bin/sh

PATH=$PATH:/usr/local/bin:/usr/local/sbin:/usr/sbin:/sbin

program=`basename $0`
if [ $# -lt 3 ]; then
        echo "usage: $program \$datadir \$from_n_days_before \$to_n_days_before"
        exit 0
fi

datadir=$1
for n in `seq $2 $3`; do
        day=`date -d "$n days ago" +%y%m%d`
        echo $day
        echo "find $datadir | grep $day | xargs -i rm -rf {}"
       find $datadir | grep $day | xargs -i rm -rf {}
done
