FROM ibm-semeru-runtimes:open-17-jre
ARG FILE_CLIENT_VERSION=2.0.0-M1
ARG FILE_CLIENT=file-client-${FILE_CLIENT_VERSION}
ARG LOG4J2=log4j2.xml
ARG START=start.sh
ARG USER=user
ENV WORKDIR=/home/$USER
ENV JAVA_ARGS="-Dlog4j.configurationFile=$LOG4J2"
ENV truststore_path="truststore.p12"
LABEL maintainer="eluinstra@luin.dev"
LABEL version=dev.luin.file.client.version=$FILE_CLIENT_VERSION
WORKDIR $WORKDIR
COPY truststore.p12 .
RUN addgroup --system $USER && \
adduser --system --ingroup $USER $USER && \
apt update && \
apt install zip -y && \
curl -OL https://github.com/eluinstra/file-client/releases/download/${FILE_CLIENT_VERSION}/${FILE_CLIENT}.jar && \
unzip -p ${FILE_CLIENT}.jar $LOG4J2 > $LOG4J2 && \
sed -i 's/ref="File"/ref="Console"/g' $LOG4J2 && \
printf "#!/bin/sh\n" > $START && \
printf "java \$JAVA_ARGS -cp \${CLASSPATH}${FILE_CLIENT}.jar dev.luin.file.client.StartGB \$@" >> $START && \
mkdir files && \
chmod u+x $START && \
chown -R $USER:$USER $WORKDIR
USER $USER:$USER
#ENTRYPOINT ["./$START"]
#EXPOSE 8443 8000
