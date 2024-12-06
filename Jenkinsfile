pipeline {
    agent any
    environment {
        DOCKER_HUB_CREDENTIALS = credentials('docker-hub') // Corrected credentials ID
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
                    sh '''
                    # Provide the execute permission to the build script
                    chmod +x bu.sh
                    
                    # Call the build.sh script with the image name
                    ./bu.sh
                    '''
                }
            }
        }
        stage('deploy Docker Image') {
            steps {
                script {
                    sh '''
                    # Provide the execute permission to the build script
                    chmod +x dep.sh
                    
                    # Call the build.sh script with the image name
                    ./dep.sh
                    '''
                }
            }
        }
    }
}
