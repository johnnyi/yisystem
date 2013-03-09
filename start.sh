#!/bin/bash
#Author : Yi Xiaohui
#MSN    : yxh_benet@hotmail.com
#QQ	: 398774310
 if [ `id -u` -eq 0 ] ; then
    	:
    else
	echo You must be root.
    	exit
 fi

 export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
 export LOCAL=/usr/local
 
 if [ -d /usr/local/yisystem ] ; then
         export export SVNDIR=/usr/local/yisystem
    else
        export SVNDIR=`pwd`
 fi

 
 chmod +x ${SVNDIR}/sbin/*.sh

 while [ -z ${select} ] ; do
 
     echo "[0] Exit"
     echo "[1] Init System"
     echo "[2] Init Users"
     echo "[3] Add User"
     echo "[4] Lock Users"
     echo "[5] Init Lan System"
     echo "[6] Init Monitor"
     echo "[7] Init Mon Key"
     echo -n ":"

     
     read select 
     case ${select} in
        1)
          ${SVNDIR}/sbin/init_users.sh
          ${SVNDIR}/sbin/init_iptables.sh
          ${SVNDIR}/sbin/init_ipv6_inittab.sh
          ${SVNDIR}/sbin/init_selinux.sh
          ${SVNDIR}/sbin/init_sshd.sh
          ${SVNDIR}/sbin/init_devel.sh
          ${SVNDIR}/sbin/init_rc.sh
          ${SVNDIR}/sbin/init_srv.sh
#          ${SVNDIR}/sbin/init_monitor.sh
	  ${SVNDIR}/sbin/init_puttykey.sh
	  ;;
        2)
          ${SVNDIR}/sbin/init_users.sh 
          ;;
	3)
	  ${SVNDIR}/sbin/users_add.sh
	  ;;
	4)
	  ${SVNDIR}/sbin/users_lock.sh
	  ;;
	5)
	  ${SVNDIR}/sbin/init_users.sh
          ${SVNDIR}/sbin/init_iptables.sh
          ${SVNDIR}/sbin/init_ipv6_inittab.sh
          ${SVNDIR}/sbin/init_selinux.sh
          ${SVNDIR}/sbin/init_devel.sh
          ${SVNDIR}/sbin/init_rc.sh
          ${SVNDIR}/sbin/init_srv.sh
	  ;;
	6)
	  ${SVNDIR}/sbin/init_monitor.sh
	  ;;
        7)
	  ${SVNDIR}/sbin/init_puttykey.sh
	  ;;
        0)
          :
          ;;
        *)
         echo "Select from underside"
         unset select
         continue
         ;;
    
     esac      



 done

 unset SVNDIR
