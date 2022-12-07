ARG OS_NAME
ARG OS_VERSION
FROM $OS_NAME:$OS_VERSION AS build
ARG OS_NAME
ARG HUGO_VERSION
ARG TARGETARCH
RUN if [ "${OS_NAME}" = "alpine" ]; then \
      apk add curl; \
    elif [ "${OS_NAME}" = "debian" ] || [ "${OS_NAME}" = "ubuntu" ]; then \
      apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get install -qq curl; \
    elif [ "${OS_NAME}" = "amazonlinux" ]; then \
      yum install -y -q tar gzip; \
    fi
RUN curl -sSL https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_linux-${TARGETARCH}.tar.gz -o - | tar -zxf - -C /usr/local/bin

FROM $OS_NAME:$OS_VERSION
COPY --from=build /usr/local/bin/hugo /usr/local/bin/hugo
ENTRYPOINT /usr/local/bin/hugo
