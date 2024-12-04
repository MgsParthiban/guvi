pipeline {
    agent any
    environment {
        DOCKER_HUB_CREDENTIALS = credentials('docker-hub') // Corrected credentials ID
        IMAGE_NAME = "mydev"
     
      
        DOCKER_HUB_IMAGE = "parthitk/d2k:19"
        SSH_KEY = credentials('SSH_KEY') 
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
                    chmod +x build.sh
                    
                    # Call the build.sh script with the image name
                    ./build.sh "${IMAGE_NAME}"
                    echo "THE IMAGE IMAGE NAME IS : ${ IMAGE_NAME}:${BUILD_NUMBER}"
                    '''
                }
            }
        }
    }
}
