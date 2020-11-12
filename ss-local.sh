#!/bin/sh

echo ${SS_LOCAL_PORT=1080}

echo ${SS_SERVER_PORT=8989}

echo ${SS_SERVER_PWD='jGZw3stLDNQii'}

echo ${SS_SERVER_METHOD='aes-256-cfb'}

echo ${SS_TIMEOUT=300}

ss-local -s $SS_SERVER_HOST -p $SS_SERVER_PORT -b 0.0.0.0 -l $SS_LOCAL_PORT -m $SS_SERVER_METHOD -k $SS_SERVER_PWD -t $SS_TIMEOUT -u
  
