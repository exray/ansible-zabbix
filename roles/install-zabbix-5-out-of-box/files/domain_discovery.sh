#!/bin/bash
JSON=$(for i in `cat /etc/zabbix/zabbix_agentd.d/domain_list.txt`; do printf "{\"{#DOMAIN}\":\"$i\"},"; done | sed 's/^\(.*\).$/\1/')
printf "{\"data\":["
printf "$JSON"
printf "]}"
