#!/bin/sh

export BASE_DIR=`dirname $(realpath $0)`
. $BASE_DIR/env.sh

cd $BASE_DIR/file-server-bin/
docker build \
  --build-arg FILE_SERVER_VERSION=${FILE_SERVER_VERSION} \
  -t ${REPO}file-server-bin:$FILE_SERVER_MAJOR_VERSION \
  -t ${REPO}file-server-bin:$FILE_SERVER_VERSION \
  -t ${REPO}file-server-bin:latest .

cd $BASE_DIR/file-client-bin/
docker build \
  --build-arg FILE_CLIENT_VERSION=${FILE_CLIENT_VERSION} \
  -t ${REPO}file-client-bin:$FILE_CLIENT_MAJOR_VERSION \
  -t ${REPO}file-client-bin:$FILE_CLIENT_VERSION \
  -t ${REPO}file-client-bin:latest .

cd $BASE_DIR/file-server-pg/
docker build \
  --build-arg FILE_SERVER_VERSION=${FILE_SERVER_VERSION} \
  --build-arg POSTGRES_DRIVER=postgresql-42.7.4.jar \
  -t ${REPO}file-server-pg:$FILE_SERVER_MAJOR_VERSION \
  -t ${REPO}file-server-pg:$FILE_SERVER_VERSION \
  -t ${REPO}file-server-pg:latest .

cd $BASE_DIR/file-client-pg/
docker build \
  --build-arg FILE_CLIENT_VERSION=${FILE_CLIENT_VERSION} \
  --build-arg POSTGRES_DRIVER=postgresql-42.7.4.jar \
  -t ${REPO}file-client-pg:$FILE_CLIENT_MAJOR_VERSION \
  -t ${REPO}file-client-pg:$FILE_CLIENT_VERSION \
  -t ${REPO}file-client-pg:latest .
