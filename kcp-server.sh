#!/bin/sh

echo ${KCP_PORT=':29900'}

echo ${TARGET_PORT='127.0.0.1:12948'}

echo ${MODE='fast2 -nocomp'}
	
echo ${MTU=1400}
	
echo ${SNDWND=1024}
	
echo ${RCVWND=1024}
	
echo ${CRYPT='salsa20'}
	
echo ${KEY='cool168'}

sleep 1
server_linux_amd64 -l $KCP_PORT -t $TARGET_PORT -mode $MODE -mtu $MTU -sndwnd $SNDWND -rcvwnd $RCVWND -crypt $CRYPT -key $KEY
