#!/bin/bash
# 2017/06/08 AcidVenom v1
# Скрипты автообнаружения IPMI датчиков для Zabbix

# Автообнаружение датчиков
# Ключ: без ключа

IFS=$'\n'
JSON="{\"data\":["
SEP=""

sensors=`ipmitool -I lanplus -H $1 -L $2 -U $3 -P $4 sensor | grep "$5"`

for sensor in $sensors
do
ID=`echo $sensor | sed "s/ *|.*//"`
NAME=`echo $ID | sed "s/.*/\U&/" | sed "s/+//g" | sed "s/ /_/g"`
LU=`echo $sensor | cut -c 54-63 | sed "s/ //g"`
LC=`echo $sensor | cut -c 66-75 | sed "s/ //g"`
LNC=`echo $sensor | cut -c 78-87 | sed "s/ //g"`
UNC=`echo $sensor | cut -c 90-99 | sed "s/ //g"`
UC=`echo $sensor | cut -c 102-111 | sed "s/ //g"`
UU=`echo $sensor | cut -c 114-123 | sed "s/ //g"`
STATUS=`echo $sensor | cut -c 46-51 | sed "s/ //g"`
JSON=$JSON"$SEP{\"{#ID}\":\"$ID\", \"{#NAME}\":\"$NAME\", \"{#LU}\":\"$LU\", \"{#LC}\":\"$LC\", \"{#LNC}\":\"$LNC\", \"{#UNC}\":\"$UNC\", \"{#UC}\":\"$UC\", \"{#UU}\":\"$UU\", \"{#STATUS}\":\"$STATUS\"}"
SEP=", "
done
JSON=$JSON"]}"
echo $JSON