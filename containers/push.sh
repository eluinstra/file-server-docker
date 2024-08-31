#!/bin/sh

export BASE_DIR=`dirname $(realpath $0)`
. $BASE_DIR/env.sh

docker image push ${REPO}file-server-bin
docker image push ${REPO}file-client-bin
