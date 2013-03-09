#!/bin/bash
#Author : Yi Xiaohui
#MSN    : yxh_benet@hotmail.com
#QQ     : 398774310

#######################################################################################
#add groups
grep -q 1010 /etc/group || /usr/sbin/groupadd -g 1010 devel
grep -q 1011 /etc/group || /usr/sbin/groupadd -g 1011 editor

#add System Administrator bbcsa
id -u ddlsa    >/dev/null 2>&1 || /usr/sbin/useradd -c "System Administrator" -d /home/ddlsa -u 500 -m -s /bin/bash -g wheel ddlsa
/usr/sbin/usermod -a -G devel ddlsa

#add comment users
id -u yixh      >/dev/null 2>&1 || /usr/sbin/useradd  -c "Yi Xiaohui"   -d /home/yixh       -m -s /bin/bash -g devel yixh
/usr/sbin/usermod -G wheel yixh
#######################################################################################
#dispose keys
temp=`mktemp`
cat <<EOF > $temp
yixh='ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAIEAn2elcoTWdkdkxJ7DGL4QYhOdKyp0UQOkVFkHNoDGrFwyFerlZ34iqAW5HSr0vjXPyTG/XKqoN8+/sKnc1xktBaikRZide5I2pkOi4qMidJ/Cro0kGshvvrVuFBFw3KLhBuI01pjlsugNW0Yh0plqU5oUww/yOaEl2KrNbL7Vx90= johnny_yi@duiduila.com'
ddlsa='ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAIEAn2elcoTWdkdkxJ7DGL4QYhOdKyp0UQOkVFkHNoDGrFwyFerlZ34iqAW5HSr0vjXPyTG/XKqoN8+/sKnc1xktBaikRZide5I2pkOi4qMidJ/Cro0kGshvvrVuFBFw3KLhBuI01pjlsugNW0Yh0plqU5oUww/yOaEl2KrNbL7Vx90= johnny_yi@duiduila.com'

EOF
for i in ddlsa yixh
do
    [ -d /home/$i/.ssh ] || mkdir /home/$i/.ssh
    grep $i $temp | awk -F"'" '{print $2}' > /home/$i/.ssh/authorized_keys
    chown -R `id -u $i`.`id -g $i` /home/$i/.ssh
    chmod 700 /home/$i/.ssh
    chmod 644 /home/$i/.ssh/authorized_keys
done

rm -f $temp
