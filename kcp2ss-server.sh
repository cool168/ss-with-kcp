#!/bin/sh

echo ${KCP_PORT=':29900'}

echo ${MODE='fast2 -nocomp'}
	
echo ${MTU=1400}
	
echo ${SNDWND=1024}
	
echo ${RCVWND=1024}
	
echo ${CRYPT='salsa20'}
	
echo ${KEY='cool168'}

echo ${SS_SERVER_PORT=9090}

echo ${SS_SERVER_METHOD='chacha20-ietf-poly1305'}

echo ${SS_SERVER_PWD='cool168'}

echo ${SS_SERVER_PASSTHROUGH='no'}

echo ${SS_TIMEOUT=300}

server_linux_amd64 -l $KCP_PORT -t 127.0.0.1:$SS_SERVER_PORT -mode $MODE -mtu $MTU -sndwnd $SNDWND -rcvwnd $RCVWND -crypt $CRYPT -key $KEY 2>&1 &

echo -e "Starting kcptun......"

echo -e "Starting shadowsocks......"

if [ $SS_SERVER_PASSTHROUGH = "no" ]
then
   ss-server -s :: -s 0.0.0.0 -p $SS_SERVER_PORT -m $SS_SERVER_METHOD -k $SS_SERVER_PWD -t $SS_TIMEOUT -u
else
   ss-server -s 127.0.0.1 -p $SS_SERVER_PORT -m $SS_SERVER_METHOD -k $SS_SERVER_PWD -t $SS_TIMEOUT -u
fi
