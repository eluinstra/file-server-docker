#!/bin/sh

export BASE_DIR=`dirname $(realpath $0)`
. $BASE_DIR/env.sh

cp ../../file-server/target/file-server-${FILE_SERVER_VERSION}.jar $BASE_DIR/file-server-bin/
cp ~/.m2/repository/org/postgresql/postgresql/${POSTGRES_DRIVER_VERSION}/${POSTGRES_DRIVER}  $BASE_DIR/file-server-pg/
# cp ~/.m2/repository/org/flywaydb/${FLYWAY_DRIVER_NAME}/${FLYWAY_DRIVER_VERSION}/${FLYWAY_DRIVER}  $BASE_DIR/file-server-pg/
cp ../../file-client/target/file-client-${FILE_CLIENT_VERSION}.jar $BASE_DIR/file-client-bin/
cp ~/.m2/repository/org/postgresql/postgresql/${POSTGRES_DRIVER_VERSION}/${POSTGRES_DRIVER}  $BASE_DIR/file-client-pg/
# cp ~/.m2/repository/org/flywaydb/${FLYWAY_DRIVER_NAME}/${FLYWAY_DRIVER_VERSION}/${FLYWAY_DRIVER}  $BASE_DIR/file-client-pg/
