FROM ibm-semeru-runtimes:open-8-jre
ARG FILE_SERVER_VERSION=1.0.0
ARG FILE_SERVER=file-server-${FILE_SERVER_VERSION}
ARG LOG4J2=log4j2.xml
ARG START=start.sh
ARG USER=user
ENV WORKDIR=/home/$USER
ENV JAVA_ARGS="-Dlog4j.configurationFile=$LOG4J2"
ENV keystore_path="keystore.p12"
LABEL maintainer="eluinstra@luin.dev"
LABEL version=dev.luin.file.server.version=$FILE_SERVER_VERSION
WORKDIR $WORKDIR
COPY keystore.p12 .
RUN addgroup --system $USER && \
adduser --system --ingroup $USER $USER && \
apt update && \
apt install zip -y && \
curl -OL https://github.com/eluinstra/file-server/releases/download/${FILE_SERVER_VERSION}/${FILE_SERVER}.jar && \
unzip -p ${FILE_SERVER}.jar $LOG4J2 > $LOG4J2 && \
sed -i 's/ref="File"/ref="Console"/g' $LOG4J2 && \
printf "#!/bin/sh\n" > $START && \
printf "java \$JAVA_ARGS -cp \${CLASSPATH}${FILE_SERVER}.jar dev.luin.file.server.StartGB \$@" >> $START && \
mkdir files && \
chmod u+x $START && \
chown -R $USER:$USER $WORKDIR
USER $USER:$USER
#ENTRYPOINT ["./$START"]
#EXPOSE 8443 8080
