#!/bin/bash

set -o errexit

readonly DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly VERSION=${VERSION:-"$(cat ${DIR}/VERSION.txt)"}
readonly IMAGE_NAME="webnodejs"
readonly IMAGE_PREFIX="${IMAGE_PREFIX:-rodrigoguedes}"

IMAGE_TAG="${IMAGE_TAG:-$VERSION}"

main() {
  build_image "$@"
  set_npm_version "$@"
}

set_npm_version() {
  npm version ${VERSION} --no-git-tag-version --allow-same-version
}

build_image() {
  local full_name=$IMAGE_PREFIX/$IMAGE_NAME:$IMAGE_TAG

  echo -n -e " \033[1;31m
  Starting to build image
    FULL_NAME:              $full_name
    IMAGE_PREFIX:           $IMAGE_PREFIX
    IMAGE_TAG:              $IMAGE_TAG
    CONTEXT:                $(realpath ./)
  \033[0m
"

  docker build \
    --tag "$IMAGE_PREFIX/$IMAGE_NAME:$IMAGE_TAG" \
    --tag "$IMAGE_PREFIX/$IMAGE_NAME:local" \
    $DIR \
    "$@"

  echo -e -n " \033[1;31m
  Succesfully built $full_name
  \033[0m"
}

main "$@"
