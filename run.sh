#!/bin/bash

set -e

if [ "${1:0:1}" != '-' ]; then
  exec "$@"
fi

if [ -z "$CROWD_URL" ]; then
	CROWD_OPTS=""
else
	CROWD_OPTS="-Dsonar.security.realm=Crowd -Dcrowd.url=${CROWD_URL} -Dcrowd.application=${CROWD_APPLICATION} -Dcrowd.password=${CROWD_PASSWORD}"
fi

chown -R sonarqube:sonarqube $SONARQUBE_HOME
exec gosu sonarqube \
  java -jar lib/sonar-application-$SONAR_VERSION.jar \
  -Dsonar.log.console=true \
  -Dsonar.jdbc.username="$SONARQUBE_JDBC_USERNAME" \
  -Dsonar.jdbc.password="$SONARQUBE_JDBC_PASSWORD" \
  -Dsonar.jdbc.url="$SONARQUBE_JDBC_URL" \
  $CROWD_URL
  -Dsonar.web.javaAdditionalOpts="$SONARQUBE_WEB_JVM_OPTS -Djava.security.egd=file:/dev/./urandom" \
  "$@"
