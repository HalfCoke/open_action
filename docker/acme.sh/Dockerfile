FROM alpine:3.15

COPY docker/acme.sh/init.sh /init.sh
RUN chmod +x /init.sh && mkdir /ssl
RUN apk --no-cache add -f \
  bash \
  openssl \
  openssh-client \
  coreutils \
  bind-tools \
  curl \
  sed \
  socat \
  tzdata \
  oath-toolkit-oathtool \
  tar \
  libidn \
  unzip \
  jq

VOLUME /ssl
WORKDIR /ssl

RUN curl -o /acme.zip https://codeload.github.com/acmesh-official/acme.sh/zip/refs/heads/master

ENTRYPOINT ["/init.sh"]
