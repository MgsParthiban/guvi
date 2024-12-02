pipeline {
    agent any
    environment {
        DOCKER_HUB_CREDENTIALS = credentials('docekr-hub') // Corrected credentials ID
        #IMAGE_NAME = "devapp"
        DOCKER_IMAGE_NAME = "parthitk/task" // Unique tag with Jenkins build number
        DOCKER_TAG = "${DOCKER_IMAGE_NAME}:${BUILD_NUMBER}"
        DOCKER_HUB_IMAGE = "parthitk/task:1"
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
                    docker.withRegistry('https://index.docker.io/v1/', "docekr-hub") {
                        sh "docker push ${DOCKER_TAG}"
                    }
                }
            }
        }
        stage('deploy Docker Image') {
            steps {
                script {
                     sh 'chmod +x deploy.sh'
                     sh './deploy.sh ${DOCKER_HUB_IMAGE}'
                   # docker.withRegistry('https://index.docker.io/v1/', "docekr-hub") {                    }
                }
            }
        }
    }
}
