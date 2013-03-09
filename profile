#!/bin/bash
#Author : Yi Xiaohui
#MSN    : yxh_benet@hotmail.com
#QQ     : 398774310

if [ -L ~/bbcserver ] ; then
    :
else
    [ -d /usr/local/bbcserver ] && ln -s /usr/local/bbcserver ~/bbcserver
fi

if [ -L ~/isystem ] ; then
	:
    else
        [ -d /usr/local/bbcserver/isystem ] && ln -s /usr/local/bbcserver/isystem ~/isystem
fi

if [ -d /srv/logs ] ; then
        [ -L ~/logs ] || ln -s /srv/logs ~/logs
fi

for i in `ls -d /usr/local/bbcserver/*` ; do
    if [ -L $i ] ; then
        if [ -L ~/`basename $i` ] ; then
                :
            else
                ln -s $i ~/`basename $i`
        fi
    fi
done

for i in `ls -d ~/*` ; do
    if [ -L $i ] ; then
        if [ -d $i ] ; then 
            :
        else
	    rm -f $i
	fi
    fi
done


[ -d /usr/local/bbcserver/httpd/bin ]     && export PATH=$PATH:/usr/local/bbcserver/httpd/bin
[ -d /usr/local/bbcserver/php/bin ]       && export PATH=$PATH:/usr/local/bbcserver/php/bin
[ -d /usr/local/bbcserver/monit/bin ]     && export PATH=$PATH:/usr/local/bbcserver/monit/bin
[ -d /usr/local/bbcserver/mysql/bin ]     && export PATH=$PATH:/usr/local/bbcserver/mysql/bin
[ -d /usr/local/bbcserver/isystem/bin ]   && export PATH=$PATH:/usr/local/bbcserver/isystem/bin
[ -d /usr/local/bbcserver/cfengine/sbin ] && export PATH=$PATH:/usr/local/bbcserver/cfengine/sbin

if [ -d /usr/local/bbcserver/mysql/bin ] ; then
    if [ -f /etc/my.multi.cnf ] ; then
        alias  mysqld_multi='/usr/local/bbcserver/mysql/bin/mysqld_multi --config-file=/etc/my.multi.cnf'
        alias  mysqld_list='grep -A1 "^\[mysqld[0-9].*" /etc/my.multi.cnf'
    fi
fi



function start 
{
bash /usr/local/bbcserver/isystem/start.sh
}

alias cp='cp -i'
alias l.='ls -d .* --color=tty'
alias ll='ls -l --color=tty'
alias ls='ls --color=tty'
alias la='ls -a'
alias mv='mv -i'
alias rm='rm -i'

if [ `id -u` -eq 0 ] ; then
        PS1='\h \t \w # '
    else
        PS1='\h \t \w $ '
fi

if [ -f /etc/debian_version ] ; then
    if [ -f ~/.bashrc ] ; then
        if grep -q LINK_PS ~/.bashrc ; then
	        :
	    else
		echo "#LINK_PS"			   	>>~/.bashrc
	        echo "if [ \`id -u\` -eq 0 ] ; then" 	>>~/.bashrc
		echo "        PS1='\h \t \w # '"   	>>~/.bashrc
		echo "    else"			  	>>~/.bashrc
		echo "        PS1='\h \t \w $ '"   	>>~/.bashrc
		echo "fi"			   	>>~/.bashrc
	fi
     fi
fi

umask 0002
