#!/usr/bin/env bash

# This script is only intended to be used for local development on this project.
# It depends on a buildx node called "beta. You can create such an environment
# by executing "docker buildx create --name beta"

set -euo pipefail

export HUGO_VERSION=$(curl -sSL https://api.github.com/repos/gohugoio/hugo/tags | jq -r "[.[].name] | .[0] | sub(\"v\";\"\")")
echo "Using hugo version ${HUGO_VERSION}"

#docker build -t moo --build-arg HUGO_VERSION="${HUGO_VERSION}" --build-arg OS_NAME=alpine --build-arg OS_VERSION=3.16 .
#docker build -t moo --build-arg HUGO_VERSION="${HUGO_VERSION}" --build-arg OS_NAME=alpine --build-arg OS_VERSION=3.17 .
#docker build -t moo --build-arg HUGO_VERSION="${HUGO_VERSION}" --build-arg OS_NAME=debian --build-arg OS_VERSION=buster .
#docker build -t moo --build-arg HUGO_VERSION="${HUGO_VERSION}" --build-arg OS_NAME=debian --build-arg OS_VERSION=bullseye .
#docker build -t moo --build-arg HUGO_VERSION="${HUGO_VERSION}" --build-arg OS_NAME=debian --build-arg OS_VERSION=bookworm .
#docker build -t moo --build-arg HUGO_VERSION="${HUGO_VERSION}" --build-arg OS_NAME=debian --build-arg OS_VERSION=buster-slim .
#docker build -t moo --build-arg HUGO_VERSION="${HUGO_VERSION}" --build-arg OS_NAME=debian --build-arg OS_VERSION=bullseye-slim .
#docker build -t moo --build-arg HUGO_VERSION="${HUGO_VERSION}" --build-arg OS_NAME=debian --build-arg OS_VERSION=bookworm-slim .
#docker build -t moo --build-arg HUGO_VERSION="${HUGO_VERSION}" --build-arg OS_NAME=ubuntu --build-arg OS_VERSION=focal .
#docker build -t moo --build-arg HUGO_VERSION="${HUGO_VERSION}" --build-arg OS_NAME=ubuntu --build-arg OS_VERSION=jammy .
docker build -t moo --build-arg HUGO_VERSION="${HUGO_VERSION}" --build-arg OS_NAME=amazonlinux --build-arg OS_VERSION=2 .
docker build -t moo --build-arg HUGO_VERSION="${HUGO_VERSION}" --build-arg OS_NAME=amazonlinux --build-arg OS_VERSION=2022 .

#docker buildx build \
#  --push \
#  --platform linux/arm64,linux/amd64 \
#  --builder beta \
#  --build-arg HUGO_VERSION="${HUGO_VERSION}" \
#  --build-arg OS_NAME="alpine" \
#  --build-arg OS_VERSION="3.16" \
#  -f Dockerfile \
#  -t truemark/hugo:beta-alpine-${HUGO_VERSION} \
#  -t truemark/hugo:beta-alpine \
#  .
