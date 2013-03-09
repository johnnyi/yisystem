#!bin/bash
logs_path="/data/log/web01_log/"
cat ${logs_path}$(date -d "yesterday" +"%Y")/$(date -d "yesterday" +"%m")/access_$(date -d "yesterday" +"%Y%m%d").log |grep -v '400' >> ${logs_path}$(date -d "yesterday" +"%Y")/$(date -d "yesterday" +"%m")/access_$(date -d "yesterday" +"%Y%m%d")_1.log 
