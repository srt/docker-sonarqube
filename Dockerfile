FROM sonarqube:lts

COPY sonarqube/run.sh $SONARQUBE_HOME/bin/run.sh
