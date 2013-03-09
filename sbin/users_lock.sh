#!/bin/bash
#Author : Yi Xiaohui
#MSN    : yxh_benet@hotmail.com
#QQ     : 398774310

remove_key_for_user ()
{
   if [ -z ${1} ] ; then
        echo need username
        exit
   fi

   HOME=`grep ${1} /etc/passwd | awk -F":" '{print $6}'`

   rm -f ${HOME}/.ssh/authorized_keys
}

make_mail_alias_for_user ()
{
    grep -q ^${1} /etc/aliases 
    newaliases  
}

echo "        Lock Users"
echo "       ---------------"
echo "Choose one of the following persons:"
echo "[0]System Administrator"
echo "[1]Yi Xiaohui"
echo "[2]Gu Hongliang"
echo "[3]Chen Xihua"
echo -n :

read username

case "$username" in

0)
remove_key_for_user nxsa
;;

1)
remove_key_for_user yixh
;;

2)
remove_key_for_user guhl
;;

3)
remove_key_for_user miracle
;;

*)
echo Errors
;;

esac
