ARG OS_NAME
ARG OS_VERSION
FROM $OS_NAME:$OS_VERSION AS build
ARG OS_NAME
ARG HUGO_VERSION
ARG TARGETARCH
ARG GO_VERSION
RUN if [ "${OS_NAME}" = "alpine" ]; then \
      apk add gcc g++ musl-dev; \
    elif [ "${OS_NAME}" = "debian" ] || [ "${OS_NAME}" = "ubuntu" ]; then \
      apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get install -qq curl gcc g++; \
    elif [ "${OS_NAME}" = "amazonlinux" ]; then \
      yum install -y -q gcc-c++; \
    fi
RUN curl -fsSL -o go$GO_VERSION.$OS_NAME-$TARGETARCH.tar.gz https://go.dev/dl/go${GO_VERSION}.linux-${TARGETARCH}.tar.gz
#RUN curl -fsSL -o go$GO_VERSION.$OS_NAME-$TARGETARCH.tar.gz https://dl.google.com/go/go$GO_VERSION.$OS_NAME-$TARGETARCH.tar.gz
RUN tar -C /usr/local -xzf go$GO_VERSION.$OS_NAME-$TARGETARCH.tar.gz
RUN export PATH=$PATH:/usr/local/go/bin && CGO_ENABLED=1 go install --tags extended github.com/gohugoio/hugo@v$HUGO_VERSION
RUN mv /root/go/bin/hugo /usr/local/bin/hugo

FROM $OS_NAME:$OS_VERSION
ARG OS_NAME
RUN if [ "${OS_NAME}" = "alpine" ]; then \
      apk add --no-cache libstdc++; \
    fi
COPY --from=build /usr/local/bin/hugo /usr/local/bin/hugo
ENTRYPOINT ["hugo"]
