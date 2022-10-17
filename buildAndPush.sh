#!/usr/bin/env bash

# override image name with optional command line argument ./buildAndPush.sh <your_custom_tag>
# otherwise it will be tagged with the ray, torch version and timestamp

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

REGISTRY='ghcr.io'
NAMESPACE='foundation-model-stack'
NAME='torchx-fsdp-base'

cd "${SCRIPT_DIR}"

TIMESTAMP=$(date "+%Y%m%d-%H%M%S")

# note: docker tags must be valid ASCII and may contain lowercase and uppercase letters, digits, underscores, periods and dashes.
# A tag name may not start with a period or a dash and may contain a maximum of 128 characters
VERSION="$(echo ${1:-pytorch${TORCH_VERSION}-$TIMESTAMP}| sed 's/[^[:alnum:]\.\_\-]//g')"
TAG="${REGISTRY}/${NAMESPACE}/${NAME}:${VERSION}"

docker build \
  -t "${TAG}" \
  .

docker push "${TAG}"


