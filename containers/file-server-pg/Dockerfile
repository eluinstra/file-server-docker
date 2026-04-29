FROM eluinstra/file-server-bin:2.1.1
ARG POSTGRES_DRIVER=
ARG FLYWAY_DRIVER_NAME=flyway-database-postgresql
ARG FLYWAY_DRIVER_VERSION=12.4.0
ARG FLYWAY_DRIVER=${FLYWAY_DRIVER_NAME}-${FLYWAY_DRIVER_VERSION}.jar
ENV CLASSPATH="${POSTGRES_DRIVER}:${FLYWAY_DRIVER}:"
ENV jdbc_driverClassName=org.postgresql.Driver
ENV jdbc_url=jdbc:postgresql://file-server-postgres:5432/file-server
ENV jdbc_username=file-server
ENV jdbc_password=file-server
COPY ${POSTGRES_DRIVER} .
# COPY ${FLYWAY_DRIVER} .
# RUN curl -OL https://jdbc.postgresql.org/download/${POSTGRES_DRIVER} && \
RUN curl -OL https://repo1.maven.org/maven2/org/flywaydb/${FLYWAY_DRIVER_NAME}/${FLYWAY_DRIVER_VERSION}/${FLYWAY_DRIVER}
#ENTRYPOINT ["./start.sh"]
#EXPOSE 8443 8080 5432
