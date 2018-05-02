#!/bin/sh

echo ${LOCAL_PORT=':12948'}

echo ${KCP_PORT='vps:39900'}

echo ${MODE='fast2 -nocomp -autoexpire 300'}
	
echo ${MTU=1400}
	
echo ${SNDWND=128}
	
echo ${RCVWND=256}
	
echo ${CRYPT='salsa20'}
	
echo ${KEY='cool168'}

echo ${CONN=1}

echo ${DSCP=46}

sleep 1
client_linux_amd64 -l $LOCAL_PORT -r $KCP_PORT -mode $MODE -mtu $MTU -sndwnd $SNDWND -rcvwnd $RCVWND -crypt $CRYPT -key $KEY -conn $CONN -dscp $DSCP
