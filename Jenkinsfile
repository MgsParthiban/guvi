pipeline {
    agent any
    environment {
        DOCKER_HUB_CREDENTIALS = credentials('docker-hub') // Corrected credentials ID
        IMAGE_NAME = "mydev"
     
      
        DOCKER_HUB_IMAGE = "parthitk/task"
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
                    docker.withRegistry('https://index.docker.io/v1/', "docker-hub") {
                         sh '''  
                            # Provide the execute permission to the build script
                            chmod +x build.sh
                            
                            # Call the build.sh script with the image name
                            ./build.sh "${DOCKER_HUB_IMAGE}"
                            echo "THE IMAGE IMAGE NAME IS : ${DOCKER_HUB_IMAGE}:${BUILD_NUMBER}"
                            '''
                            }
                    }
                }
            }
        }
    }
