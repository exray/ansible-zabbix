#!/bin/sh
 
# получаем имя домена
DOMAIN=$1
 
# получаем имя зоны
ZONE=`echo $DOMAIN | sed 's/\./ /' | awk '{ print $2 }'`
 
# получаем дату протухания домена
# Должна вернуться в формате ГГГГ-ММ-ДД (год-месяц-день)
case "$ZONE" in
	ru|net.ru|org.ru|pp.ru|su|рф)
		DATE=`whois $DOMAIN | grep paid-till | awk '{ print $2 }' | sed 's/\./-/g'`
		;;
	com|net|org|info|me|rent|онлайн|online|рус)
		DATE=`whois $DOMAIN | grep "Registry Expiry Date:" | sed 's/Registry Expiry Date: //g;s/T/ /g' | awk '{ print $1 }'`
		;;
	co.uk)
		DATE=`whois $DOMAIN | grep "Expiry date:" | sed 's/Expiry date: //g;s/T/ /g' | awk '{ print $1 }'`
		;;
	*)
		echo "-666"
		exit 1

esac
 
# считаем дни и выводим
expr \( `date --date="$DATE" +%s` - `date +%s` \) / 60 / 60 / 24
