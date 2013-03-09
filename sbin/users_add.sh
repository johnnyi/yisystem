#!/bin/bash
#Author : Yi Xiaohui
#MSN    : yxh_benet@hotmail.com
#QQ     : 398774310

#add groups
grep -q 1010 /etc/group || grep -q devel  /etc/group || groupadd -g 1010 devel
grep -q 1011 /etc/group || grep -q editor /etc/group || groupadd -g 1011 editor

create_key_for_user ()
{
   if [ -z ${1} ] ; then
        echo error
        exit
   fi

   HOME=`grep ${1} /etc/passwd | awk -F":" '{print $6}'`

   [ -d ${HOME}/.ssh ] || mkdir ${HOME}/.ssh
   echo ${key} > ${HOME}/.ssh/authorized_keys
   chown -R `id -u ${1}`.`id -g ${1}` ${HOME}/.ssh
   chmod 700 ${HOME}/.ssh
   chmod 644 ${HOME}/.ssh/authorized_keys
}

make_mail_alias_for_user ()
{
    grep -q ^${1} /etc/aliases || sed -i '/a/${1}    :${2}/' /etc/aliases
    newaliases  
}

echo "        Create Users"
echo "       ---------------"
echo "Choose one of the following persons:"
echo "[0]System Administrator"
echo "[1]Yi Xiaohui"
echo "[2]Liu Tao"
echo -n :

read username

case "$username" in

0)
#add System Administrator ddlsa
if [ -f /etc/debian_version ] ; then
        id -u ddlsa >/dev/null 2>&1   || /usr/sbin/useradd -c "System Administrator" -d /home/ddlsa -m -s /bin/bash -g root ddlsa
    else
        id -u ddlsa >/dev/null 2>&1   || /usr/sbin/useradd -c "System Administrator" -d /home/ddlsa -m -s /bin/bash -g wheel ddlsa
fi
key='ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAAgQDDBe/Y/onvhDsRmZP+y4BqS0AWO5IQ+fAviesz1/G70fIfHkbRXs0j11PzRKmLTHSlD2yERInS28KgJZN+2li5V9jldfB+rcv0F4rjQ88OWpAGNgYeW3LBFtv53BMEbNs5z2DSUl/cp6T0p9fFK/VSLhFH6h/+AozBZy15v7ikdw== johnny_yi@duiduila.com'
create_key_for_user ddlsa
;;

1)
id -u yixh >/dev/null 2>&1    || /usr/sbin/useradd -c "Yi Xiaohui"     -d /home/yixh -m -s /bin/bash -g devel yixh
key='ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAAgQDDBe/Y/onvhDsRmZP+y4BqS0AWO5IQ+fAviesz1/G70fIfHkbRXs0j11PzRKmLTHSlD2yERInS28KgJZN+2li5V9jldfB+rcv0F4rjQ88OWpAGNgYeW3LBFtv53BMEbNs5z2DSUl/cp6T0p9fFK/VSLhFH6h/+AozBZy15v7ikdw== johnny_yi@duiduila.com'
create_key_for_user yixh
;;

2)
id -u liut  >/dev/null 2>&1   || /usr/sbin/useradd -c "Liu Tao"   -d /home/liut -m -s /bin/bash -g devel liut
key='ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAIEAhbZpg5P/SvIHZTf7IP7MpyelMPDgsRYHqUQObOHToft/IP+CYc0EJY1YO4QNwGzgddDfocDyu3ak4ZixMhNlcH2wPgm5Jg/LaaFwGpt3PUZ3GJQZ4eD0aZPjWYG3CYLxbXs9nKf6JdDk7Obz6xFEAB2XFXMHgbK24YV0uAFa3qk='
create_key_for_user liut
;;

*)
echo Errors
;;

esac
