pipeline {
    agent { docker { image 'python:slim' } }
    stages {
        stage('build') {
            steps {
                sh 'id; ls -la .; python3 src/main.py'
            }
        }
    }
}