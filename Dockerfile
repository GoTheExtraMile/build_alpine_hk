FROM alpine:3.11

MAINTAINER un

LABEL msg="use alpine3.11 include bash glibc time_zone Asia/Shanghai"

#设置glibc版本号
ENV GLIBC_PKG_VERSION=2.31-r0 \
#设置时区为上海
    TIME_ZONE=Asia/Shanghai

RUN apk add --no-cache --update-cache curl ca-certificates bash tzdata \ 
  && curl -Lo /etc/apk/keys/andyshinn.rsa.pub "https://github.com/andyshinn/alpine-pkg-glibc/releases/download/${GLIBC_PKG_VERSION}/andyshinn.rsa.pub" \ 
  && curl -Lo glibc-${GLIBC_PKG_VERSION}.apk "https://github.com/andyshinn/alpine-pkg-glibc/releases/download/${GLIBC_PKG_VERSION}/glibc-${GLIBC_PKG_VERSION}.apk" \ 
  && curl -Lo glibc-bin-${GLIBC_PKG_VERSION}.apk "https://github.com/andyshinn/alpine-pkg-glibc/releases/download/${GLIBC_PKG_VERSION}/glibc-bin-${GLIBC_PKG_VERSION}.apk" \ 
  && curl -Lo glibc-i18n-${GLIBC_PKG_VERSION}.apk "https://github.com/andyshinn/alpine-pkg-glibc/releases/download/${GLIBC_PKG_VERSION}/glibc-i18n-${GLIBC_PKG_VERSION}.apk" \ 
  && apk --allow-untrusted add glibc-${GLIBC_PKG_VERSION}.apk glibc-bin-${GLIBC_PKG_VERSION}.apk glibc-i18n-${GLIBC_PKG_VERSION}.apk \
  && echo "${TIME_ZONE}" > /etc/timezone \
  && cp -rf /usr/share/zoneinfo/${TIME_ZONE} /etc/localtime \
  && apk del curl ca-certificates tzdata \ 
  && rm -rf /tmp/* /var/cache/apk/* \
  && rm -rf /usr/share/zoneinfo \ 
  && echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf \
  && echo "alias ll='ls -al'" >> /etc/profile
