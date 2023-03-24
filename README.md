# aurora-test
Aurora Labs Test

Running Jenkins Server:
./run_jenkins_master.sh up
This script would perform the following steps:
- Check if Jenkins configuration already exists and if not - would configure it;
- Run docker compose to create Jenkins master image if not exists and run it;
- Jenkins is configured with the multibranch job polling GitHub once in 5 min (at home computer with firewall push trigger is not awailable) an if there's any change python script is run.

For security purpose ngnx frontend level was created. User/passwords are stored plain in jenkins.env, but in "real" life should be encoded/used secrets/keys/etc.
For saving storage old builds are discarded.
For maintainability - configuration as code was used.

./run_jenkins_cloud.sh up - is another solution using Jenkins clouds.
