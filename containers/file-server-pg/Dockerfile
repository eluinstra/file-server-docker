FROM eluinstra/file-server-bin:1.0.0
ARG POSTGRES_DRIVER=
ENV CLASSPATH="${POSTGRES_DRIVER}:"
ENV jdbc_driverClassName=org.postgresql.Driver
ENV jdbc_url=jdbc:postgresql://postgres:5432/file-server
ENV jdbc_username=file-server
ENV jdbc_password=password
COPY ${POSTGRES_DRIVER} .
# RUN curl -OL https://jdbc.postgresql.org/download/${POSTGRES_DRIVER}
#ENTRYPOINT ["./start.sh"]
#EXPOSE 8443 8080 5432
