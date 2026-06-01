#!/bin/sh

set -eu

export BASE_DIR=`dirname $(realpath $0)`
. $BASE_DIR/env.sh

ARCH="$(dpkg --print-architecture)"
ARCH_OPTION="${1:-$ARCH}"

if ! docker buildx version >/dev/null 2>&1; then
  echo "docker buildx is required"
  exit 1
fi

case "$ARCH" in
  amd64|arm64)
    ;;
  *)
    echo "Unsupported host architecture '$ARCH'"
    exit 1
    ;;
esac

case "$ARCH_OPTION" in
  amd64|arm64)
    ARCH_LIST="$ARCH_OPTION"
    ;;
  all)
    ARCH_LIST="amd64 arm64"
    ;;
  *)
    echo "Unsupported option '$ARCH_OPTION'"
    echo "Usage: $0 [amd64|arm64|all]"
    exit 1
    ;;
esac

for TARGET_ARCH in $ARCH_LIST; do
  PLATFORM="linux/${TARGET_ARCH}"

  echo "Building file-server-bin for ${TARGET_ARCH}"
  cd "$BASE_DIR/file-server-bin/"
  docker buildx build \
    --platform "$PLATFORM" \
    --build-arg FILE_SERVER_VERSION="${FILE_SERVER_VERSION}" \
    -t "${REPO}file-server-bin:${FILE_SERVER_MAJOR_VERSION}-${TARGET_ARCH}" \
    -t "${REPO}file-server-bin:${FILE_SERVER_VERSION}-${TARGET_ARCH}" \
    -t "${REPO}file-server-bin:latest-${TARGET_ARCH}" \
    --load .
  if [ "$TARGET_ARCH" = "$ARCH" ]; then
    docker tag "${REPO}file-server-bin:${FILE_SERVER_VERSION}-${TARGET_ARCH}" "file-server-bin:${FILE_SERVER_VERSION}"
  fi

  echo "Building file-client-bin for ${TARGET_ARCH}"
  cd "$BASE_DIR/file-client-bin/"
  docker buildx build \
    --platform "$PLATFORM" \
    --build-arg FILE_CLIENT_VERSION="${FILE_CLIENT_VERSION}" \
    -t "${REPO}file-client-bin:${FILE_CLIENT_MAJOR_VERSION}-${TARGET_ARCH}" \
    -t "${REPO}file-client-bin:${FILE_CLIENT_VERSION}-${TARGET_ARCH}" \
    -t "${REPO}file-client-bin:latest-${TARGET_ARCH}" \
    --load .
  if [ "$TARGET_ARCH" = "$ARCH" ]; then
    docker tag "${REPO}file-client-bin:${FILE_CLIENT_VERSION}-${TARGET_ARCH}" "file-client-bin:${FILE_CLIENT_VERSION}"
  fi

  echo "Building file-server-pg for ${TARGET_ARCH}"
  cd "$BASE_DIR/file-server-pg/"
  docker buildx build \
    --platform "$PLATFORM" \
    --build-arg IMAGE_REPO="${REPO}" \
    --build-arg FILE_SERVER_VERSION="${FILE_SERVER_VERSION}-${TARGET_ARCH}" \
    --build-arg POSTGRES_DRIVER="${POSTGRES_DRIVER}" \
    --build-arg FLYWAY_DRIVER="${FLYWAY_DRIVER}" \
    -t "${REPO}file-server-pg:${FILE_SERVER_MAJOR_VERSION}-${TARGET_ARCH}" \
    -t "${REPO}file-server-pg:${FILE_SERVER_VERSION}-${TARGET_ARCH}" \
    -t "${REPO}file-server-pg:latest-${TARGET_ARCH}" \
    --load .
  if [ "$TARGET_ARCH" = "$ARCH" ]; then
    docker tag "${REPO}file-server-pg:${FILE_SERVER_VERSION}-${TARGET_ARCH}" "file-server-pg:${FILE_SERVER_VERSION}"
  fi

  echo "Building file-client-pg for ${TARGET_ARCH}"
  cd "$BASE_DIR/file-client-pg/"
  docker buildx build \
    --platform "$PLATFORM" \
    --build-arg IMAGE_REPO="${REPO}" \
    --build-arg FILE_CLIENT_VERSION="${FILE_CLIENT_VERSION}-${TARGET_ARCH}" \
    --build-arg POSTGRES_DRIVER="${POSTGRES_DRIVER}" \
    --build-arg FLYWAY_DRIVER="${FLYWAY_DRIVER}" \
    -t "${REPO}file-client-pg:${FILE_CLIENT_MAJOR_VERSION}-${TARGET_ARCH}" \
    -t "${REPO}file-client-pg:${FILE_CLIENT_VERSION}-${TARGET_ARCH}" \
    -t "${REPO}file-client-pg:latest-${TARGET_ARCH}" \
    --load .
  if [ "$TARGET_ARCH" = "$ARCH" ]; then
    docker tag "${REPO}file-client-pg:${FILE_CLIENT_VERSION}-${TARGET_ARCH}" "file-client-pg:${FILE_CLIENT_VERSION}"
  fi
done