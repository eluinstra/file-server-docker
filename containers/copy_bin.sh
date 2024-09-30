#!/bin/sh

export BASE_DIR=`dirname $(realpath $0)`
. $BASE_DIR/env.sh

cp ~/gb/file-server/target/file-server-${FILE_SERVER_VERSION}.jar $BASE_DIR/file-server-bin/
cp ~/gb/file-client/target/file-client-${FILE_CLIENT_VERSION}.jar $BASE_DIR/file-client-bin/
cp ~/.m2/repository/org/postgresql/postgresql/42.7.4/postgresql-42.7.4.jar  $BASE_DIR/file-server-pg/
cp ~/.m2/repository/org/postgresql/postgresql/42.7.4/postgresql-42.7.4.jar  $BASE_DIR/file-client-pg/
