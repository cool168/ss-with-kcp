FROM alpine:3.5

ENV TZ 'Asia/Shanghai'

ENV SS_LIBEV_VERSION 3.0.5

ENV KCP_VERSION 20170329 

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
    && rm -rf kcptun-linux-amd64-$KCP_VERSION.tar.gz \
        shadowsocks-libev-$SS_LIBEV_VERSION.tar.gz \
        shadowsocks-libev-$SS_LIBEV_VERSION \
        /var/cache/apk/*
ADD kcp2ss-server.sh /kcp2ss-server.sh
ADD ss2kcp-client.sh /ss2kcp-client.sh
ADD ss-local.sh /ss-local.sh
ADD ss-server.sh /ss-server.sh
RUN chmod +x /*.sh


