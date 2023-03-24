pipeline {
    agent { docker { image 'python:slim' } }
    stages {
        stage('build') {
            steps {
                sh 'src/main.py'
            }
        }
    }
}