#!/bin/sh

export BASE_DIR=`dirname $(realpath $0)`
. $BASE_DIR/env.sh

rm $BASE_DIR/file-server-bin/file-server-*.jar
rm $BASE_DIR/file-server-pg/$POSTGRES_DRIVER
rm $BASE_DIR/file-server-pg/$FLYWAY_DRIVER
rm $BASE_DIR/file-client-bin/file-client-*.jar
rm $BASE_DIR/file-client-pg/$POSTGRES_DRIVER
rm $BASE_DIR/file-client-pg/$FLYWAY_DRIVER
