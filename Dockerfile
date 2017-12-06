FROM alpine:3.5

ENV TZ 'Asia/Shanghai'

ENV SS_LIBEV_VERSION 3.0.8

ENV KCP_VERSION 20170525 

ENV KCPRAW_VERSION 20171121

RUN apk upgrade --no-cache \
    && apk add --no-cache bash tzdata libsodium \
    && apk add --no-cache --virtual .build-deps \
        autoconf \
        build-base \
        curl \
        libev-dev \
        libtool \
        linux-headers \
        udns-dev \
        libsodium-dev \
        mbedtls-dev \
        pcre-dev \
        tar \
        udns-dev \
    && curl -sSLO https://github.com/shadowsocks/shadowsocks-libev/releases/download/v$SS_LIBEV_VERSION/shadowsocks-libev-$SS_LIBEV_VERSION.tar.gz \
    && tar -zxf shadowsocks-libev-$SS_LIBEV_VERSION.tar.gz \
    && cd shadowsocks-libev-$SS_LIBEV_VERSION \
    && ./configure --prefix=/usr --disable-documentation \
    && make install && cd ../ \
    && curl -sSLO https://github.com/xtaci/kcptun/releases/download/v$KCP_VERSION/kcptun-linux-amd64-$KCP_VERSION.tar.gz \
    && tar -zxf kcptun-linux-amd64-$KCP_VERSION.tar.gz \
    && mv server_linux_amd64 /usr/bin/server_linux_amd64 \
    && mv client_linux_amd64 /usr/bin/client_linux_amd64 \   
    && curl -sSLO https://github.com/ccsexyz/kcpraw/releases/download/v20171122/kcpraw-linux-amd64-$KCPRAW_VERSION.tar.gz \ 
    && tar -zxf kcpraw-linux-amd64-$KCPRAW_VERSION.tar.gz \
    && mv kcpraw_client_linux_amd64 /usr/bin/kcpraw_client_linux_amd64 \
    && mv kcpraw_client_linux_amd64_pprof /usr/bin/kcpraw_client_linux_amd64_pprof \      
    && mv kcpraw_server_linux_amd64 /usr/bin/kcpraw_server_linux_amd64 \
    && mv kcpraw_server_linux_amd64_pprof /usr/bin/kcpraw_server_linux_amd64_pprof \      
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && runDeps="$( \
        scanelf --needed --nobanner /usr/bin/ss-* \
            | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
            | xargs -r apk info --installed \
            | sort -u \
        )" \
    && apk add --no-cache --virtual .run-deps $runDeps \
    && apk del .build-deps \
    && apk add --no-cache privoxy \
    && rm -rf kcptun-linux-amd64-$KCP_VERSION.tar.gz \
        kcpraw-linux-amd64-$KCPRAW_VERSION.tar.gz \
        shadowsocks-libev-$SS_LIBEV_VERSION.tar.gz \
        shadowsocks-libev-$SS_LIBEV_VERSION \
        /var/cache/apk/*
ADD kcp2ss-server.sh /kcp2ss-server.sh
ADD ss2kcp-client.sh /ss2kcp-client.sh
ADD ss-local.sh /ss-local.sh
ADD ss-server.sh /ss-server.sh
ADD p2ss2kcp-client.sh /p2ss2kcp-client.sh
ADD kcpraw-client.sh /kcpraw-client.sh
RUN chmod +x /*.sh


