ARG FILE_CLIENT_VERSION=0.0.0
FROM eluinstra/file-client-bin:${FILE_CLIENT_VERSION}
ARG POSTGRES_DRIVER=
ARG FLYWAY_DRIVER_NAME=flyway-database-postgresql
ARG FLYWAY_DRIVER_VERSION=12.4.0
ARG FLYWAY_DRIVER=${FLYWAY_DRIVER_NAME}-${FLYWAY_DRIVER_VERSION}.jar
ENV CLASSPATH="${POSTGRES_DRIVER}:${FLYWAY_DRIVER}:"
ENV jdbc_driverClassName=org.postgresql.Driver
ENV jdbc_url=jdbc:postgresql://file-client-postgres:5432/file-client
ENV jdbc_username=file-client
RUN curl -OL https://jdbc.postgresql.org/download/${POSTGRES_DRIVER} && \
curl -OL https://repo1.maven.org/maven2/org/flywaydb/${FLYWAY_DRIVER_NAME}/${FLYWAY_DRIVER_VERSION}/${FLYWAY_DRIVER}
#ENTRYPOINT ["./start.sh"]
#EXPOSE 8443 8000 5432
