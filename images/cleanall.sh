#!/bin/sh

set -eu

export BASE_DIR=`dirname $(realpath $0)`
. $BASE_DIR/env.sh

ARCH="$(dpkg --print-architecture)"
ARCH_OPTION="${1:-$ARCH}"

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
			continue
			;;
	esac

	docker image rm -f "${IMAGE}:${VERSION_TAG}" 2>/dev/null || true

	for TARGET_ARCH in $ARCH_LIST; do
		docker image rm -f "${REPO}${IMAGE}:${MAJOR_TAG}-${TARGET_ARCH}" 2>/dev/null || true
		docker image rm -f "${REPO}${IMAGE}:${VERSION_TAG}-${TARGET_ARCH}" 2>/dev/null || true
		docker image rm -f "${REPO}${IMAGE}:latest-${TARGET_ARCH}" 2>/dev/null || true
	done
done
