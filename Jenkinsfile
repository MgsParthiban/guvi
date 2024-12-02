pipeline {
    agent any
    environment {
        DOCKER_HUB_CREDENTIALS = credentials('docker-hub') // Corrected credentials ID
        IMAGE_NAME = "myapp"
        DOCKER_IMAGE_NAME = "parthi/d2k:${env.BUILD_NUMBER}" // Unique tag with Jenkins build number
    }
    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    sh '''
                    # Provide the execute permission to the build script
                    chmod +x build.sh
                    
                    # Call the build.sh script with the image name
                    ./build.sh "${DOCKER_IMAGE_NAME}"
                    '''
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_HUB_CREDENTIALS) {
                        sh "docker push ${DOCKER_IMAGE_NAME}"
                    }
                }
            }
        }
    }
}
