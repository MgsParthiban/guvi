pipeline {
    agent any   
    environment {
        DOCKER_HUB_CREDENTIALS = credentials('docekr-hub')
    }
    stages {
        stage('Clone Code') {
            steps {
                echo "scm checkout"
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    sh 'chmod +x build.sh'
                    sh './build.sh'
                }
            }
        }
    }
}
