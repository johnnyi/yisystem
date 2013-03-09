#Author: Johnny ( yxhbenet@vip.qq.com)
#
#Last modify: 2009-02-23
#************************************************************

MEMCACHED_HOME='/usr/local/memcache'
PORT='11555'
IP='0.0.0.0'
USER='memcache'
MEM_SIZE='4000'


start() {
        if [ ! -x "$MEMCACHED_HOME/bin/memcached" ]
        then
                echo "Can not execute $MEMCACHED_HOME/bin/memcached"
                exit 127
        fi
        MC_PID=`ps -ef | grep $USER | grep memcached | grep -v 'memcached\.sh' | grep -v grep | awk '{print $2}'`
#        if [ ! -z $MC_PID ]
#        then
#                echo "Memcached had started, PID=$MC_PID"
#                exit 99
#        fi
        echo -n "Start Memcached ... "
        $MEMCACHED_HOME/bin/memcached -d -m $MEM_SIZE -l $IP -p $PORT -u $USER
        if [ $? -ne 0 ]
        then
                echo "[Failed]"
                exit 127
        else
                echo "[OK]"
        fi
}

stop() {
        MC_PID=`ps -ef | grep $USER | grep memcached | grep -v 'memcached\.sh' | grep -v grep | awk '{print $2}'`
        if [ -z $MC_PID ]
        then
                echo "Memcached not start"
                exit 99
        fi
        echo -n "Stop Memcached PID=$MC_PID ... "
        kill -9 $MC_PID
        if [ $? -ne 0 ]
        then
                echo "[Failed]"
                exit 127
        else
                echo "[OK]"
        fi
}

status() {
        ps -ef | grep $USER|grep memcached | grep -v grep | grep -v 'memcached\.sh'
}

reload() {
        stop
        sleep 3
        start
}

case "$1" in
    "start")
        start
        ;;

    "stop")
        stop
        ;;

    "status")
        status
        ;;

    "reload")
                reload
        ;;

    *)
        echo "Usage : `basename $0` { start | stop | status | reload }"
        exit 0
        ;;
esac
