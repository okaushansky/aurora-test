#! /usr/bin/env bash

set -x 

export SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
export UGID=$(id -g)
export UUID=$(id -u)
export DGID=$(stat /var/run/docker.sock -c %g)

CASCYML=${SCRIPT_DIR}/jcasc/jcasc.yml
JCIENV=${SCRIPT_DIR}/jcasc/jenkins.env

if [[ -f ${SCRIPT_DIR}/jenkins-data/config.xml ]] ; then
    echo "Jenkins CI already configured. Jenkins CasC configuration would not be deployed"
    rm -f ${CASCYML} ${JCIENV}; touch ${CASCYML} ${JCIENV}
else
    echo "First time run. Jenkins CasC configuration will be deployed"
    cp -f ${CASCYML}.tmpl ${CASCYML}
    cp -f ${JCIENV}.tmpl ${JCIENV}
fi

docker compose -f ${SCRIPT_DIR}/docker-compose.yml "$@"