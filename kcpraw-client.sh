#!/bin/sh

echo ${LOCAL_PORT=':12948'}

echo ${KCP_PORT='vps:39900'}

echo ${MODE='fast2 -ds 0 -ps 0 -nocomp'}
	
echo ${MTU=1400}

echo ${KEY='cool168'}

sleep 1
kcpraw_client_linux_amd64 -l $LOCAL_PORT -r $KCP_PORT  -key $KEY -mtu $MTU -mode $MODE
