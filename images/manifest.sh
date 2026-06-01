#!/bin/sh

set -eu

export BASE_DIR=`dirname $(realpath $0)`
. $BASE_DIR/env.sh

for IMAGE in $IMAGE_NAMES; do
  case "$IMAGE" in
    file-server-bin|file-server-pg)
      MAJOR_TAG="$FILE_SERVER_MAJOR_VERSION"
      VERSION_TAG="$FILE_SERVER_VERSION"
      ;;
    file-client-bin|file-client-pg)
      MAJOR_TAG="$FILE_CLIENT_MAJOR_VERSION"
      VERSION_TAG="$FILE_CLIENT_VERSION"
      ;;
    *)
      echo "Unknown image: $IMAGE"
      exit 1
      ;;
  esac

  for TAG in "$MAJOR_TAG" "$VERSION_TAG" "latest"; do
    TARGET="${REPO}${IMAGE}:${TAG}"

    docker manifest rm "$TARGET" >/dev/null 2>&1 || true

    docker manifest create "$TARGET" \
      --amend "${REPO}${IMAGE}:${TAG}-amd64" \
      --amend "${REPO}${IMAGE}:${TAG}-arm64"

    docker manifest annotate "$TARGET" "${REPO}${IMAGE}:${TAG}-amd64" --arch amd64
    docker manifest annotate "$TARGET" "${REPO}${IMAGE}:${TAG}-arm64" --arch arm64

    docker manifest push --purge "$TARGET"
  done
done
