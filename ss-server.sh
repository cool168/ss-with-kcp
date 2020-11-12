#!/bin/sh

echo ${ENABLE_CFGFILE='no'}

echo ${SS_SERVER_PWD='jGZw3stLDNQii'}

echo ${SS_SERVER_PORT=8989}

echo ${SS_SERVER_METHOD='aes-256-cfb'}

echo ${SS_TIMEOUT=300}

sleep 1

if [ $ENABLE_CFGFILE = "yes" ]
then
	ss-server -u -c /etc/ss-config.json
else
	ss-server -s :: -s 0.0.0.0 -p $SS_SERVER_PORT -m $SS_SERVER_METHOD -k $SS_SERVER_PWD -t $SS_TIMEOUT -u
fi
