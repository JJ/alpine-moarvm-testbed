FROM alpine:latest

LABEL version="1.0.0" maintainer="JJMerelo@GMail.com"

# Environment
ENV PATH="/root/raku-install/bin:/root/raku-install/share/perl6/site/bin:/root/.rakudobrew/bin:${PATH}" \
    PKGS="curl git perl curl-dev linux-headers make gcc musl-dev wget" \
    ENV="/root/.profile"

# Basic setup, programs and init
RUN mkdir /home/raku \
    && apk update && apk upgrade \
    && apk add --no-cache $PKGS \
    && mkdir /sh && cd /sh \
    && echo "/bin/sh" > entrypoint.sh \
    && echo "perl Configure.pl && make" >> entrypoint.sh \
    && chmod +x entrypoint.sh


WORKDIR /home/raku
ENTRYPOINT ["/sh/entrypoint.sh"]
