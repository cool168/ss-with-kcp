#!/bin/sh

PRIVOXY_CONF="/privoxy.conf"

if [ ! -f "$PRIVOXY_CONF" ]; then
	touch PRIVOXY_CONF
	echo listen-address 0.0.0.0:$HTTP > $PRIVOXY_CONF
	echo forward-socks5 / 127.0.0.1:$SOCKS5 . >> $PRIVOXY_CONF
fi

echo ${LOCAL_PORT=12948}

echo ${KCP_PORT='vps:29900'}

echo ${SHOW_LOGS='yes'}

echo ${MODE='fast2 -nocomp -autoexpire 300'}
	
echo ${MTU=1400}
	
echo ${SNDWND=128}
	
echo ${RCVWND=256}
	
echo ${CRYPT='salsa20'}
	
echo ${KEY='cool168'}

echo ${CONN=1}

echo ${DSCP=46}

echo ${SS_LOCAL_PORT=8989}

echo ${SS_SERVER_METHOD='aes-256-cfb'}

echo ${SS_SERVER_PWD='cool168'}

client_linux_amd64 -l 127.0.0.1:$LOCAL_PORT -r $KCP_PORT -mode $MODE -mtu $MTU -sndwnd $SNDWND -rcvwnd $RCVWND -crypt $CRYPT -key $KEY -conn $CONN -dscp $DSCP 2>&1 &

echo -e "Starting kcptun......"

echo -e "Starting shadowsocks......"

ss-local -s 127.0.0.1 -p $LOCAL_PORT -b 0.0.0.0 -l $SS_LOCAL_PORT -m $SS_SERVER_METHOD -k $SS_SERVER_PWD -t 60 -u &

privoxy --no-daemon $PRIVOXY_CONF
