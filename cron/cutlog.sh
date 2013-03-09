#!/bin/bash
logs_path="/data/log/nginx/"
/bin/mkdir -p ${logs_path}$(date -d "yesterday" +"%Y")/$(date -d "yesterday" +"%m")/
/bin/mv ${logs_path}web01.kj.quitein.com-access.log ${logs_path}$(date -d "yesterday" +"%Y")/$(date -d "yesterday" +"%m")/access_$(date -d "yesterday" +"%Y%m%d").log
/bin/kill -USR1 `cat /usr/local/nginx/logs/nginx.pid`

