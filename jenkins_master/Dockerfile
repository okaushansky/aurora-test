FROM jenkins/jenkins:lts

USER root

ARG UGID
ARG UUID
ARG DGID
ARG SCRIPT_DIR

# Config
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false --logfile=/var/log/jenkins/jenkins.log 

USER jenkins

# Plugins list: copy and install
COPY ${SCRIPT_DIR}/env/plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --clean-download-directory --list --view-security-warnings -f /usr/share/jenkins/ref/plugins.txt

# COPY jcasc/jcasc.yml ${CASC_JENKINS_CONFIG}

USER root

# Propagate local user and docker group
RUN groupadd -g ${DGID} docker; \
    groupmod -g ${UGID} jenkins; \
    usermod -u ${UUID} -g ${UGID} jenkins; \
    usermod -aG docker jenkins ; \
    chown -R ${UUID} /usr/share/jenkins/ref; \
    chown -R ${UUID}.${UGID} /var/jenkins_home; \
    mkdir /var/log/jenkins; \
    chown -R ${UUID}.${UGID} /var/log/jenkins

# Install Docker toolchain
RUN apt-get update; apt-get install -y apt-utils; \
    curl -s https://get.docker.com/ | bash -s

USER jenkins

WORKDIR $JENKINS_HOME