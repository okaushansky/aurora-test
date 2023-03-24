#! /usr/bin/env bash
export SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
export UGID=$(id -g)
export UUID=$(id -u)
export DGID=$(stat /var/run/docker.sock -c %g)

CASCYML=${SCRIPT_DIR}/jcasc/jcasc_cloud.yml
JCIENV=${SCRIPT_DIR}/jcasc/jenkins.env

docker image inspect jenkins-agent-python >/dev/null 2>&1 || {
    echo "jenkins-agent-python image not found. Baking new one"
    docker build -f ${SCRIPT_DIR}/Dockerfile.agent-jnlp-python -t jenkins-agent-python ${SCRIPT_DIR}
} 

if [[ -f ${SCRIPT_DIR}/jenkins-data/config.xml ]] ; then
    echo "Jenkins CI already configured. Jenkind CasC configuration would not be deployed"
    rm -f ${CASCYML} ${JCIENV}; touch ${CASCYML} ${JCIENV}
else
    echo "First time run. Jenkind CasC configuration will be deployed"
    cp -f ${CASCYML}.tmpl ${CASCYML}
    cp -f ${JCIENV}.tmpl ${JCIENV}
fi

docker compose -f ${SCRIPT_DIR}/docker-compose.yml "$@"