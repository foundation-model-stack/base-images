#!/usr/bin/env bash

# override image name with optional command line argument ./buildAndPush.sh <your_custom_tag>
# otherwise it will be tagged with the ray, torch version and timestamp

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

REGISTRY='ghcr.io'
NAMESPACE='foundation-model-stack'
NAME='base'

cd "${SCRIPT_DIR}"

TIMESTAMP=$(date "+%Y%m%d-%H%M%S")

# note: docker tags must be valid ASCII and may contain lowercase and uppercase letters, digits, underscores, periods and dashes.
# A tag name may not start with a period or a dash and may contain a maximum of 128 characters
VERSION="$(echo ${1:-ray${RAY_VERSION}-pytorch${TORCH_VERSION}-$TIMESTAMP}| sed 's/[^[:alnum:]\.\_\-]//g')"
TAG="${REGISTRY}/${NAMESPACE}/${NAME}:${VERSION}"

docker build \
  --build-arg RAY_VERSION="${RAY_VERSION}" \
  --build-arg TORCH_VERSION="${TORCH_VERSION}" \
  -t "${TAG}" \
  .

docker push "${TAG}"


