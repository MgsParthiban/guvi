pipeline {
    agent any
    environment {
        DOCKER_HUB_CREDENTIALS = credentials('docekr-hub')
        BUILD_NUMBER = "${env.BUILD_NUMBER}" // Provided automatically by Jenkins
        IMAGE_NAME = "myapp"
         DOCKER_IMAGE_NAME = 'parthi/d2k:${IMAGE_NAME}'
    }
    stages {
        stage('Build Docker Image') {
            steps {
                sh '''
                # Define the image name
               
                
                # Provide the execute permission
                chmod +x build.sh

                # Call the build.sh script with the image name
                ./build.sh $IMAGE_NAME
                '''
            }
        }
        stage ('Image pushing') {
            steps {
                // This step should not normally be used in your script. Consult the inline help for details.
                docker.withRegistry('https://index.docker.io/v1/', "docekr-hub") {
                    docker.image ("${DOCKER_IMAGE_NAME}").push()
                }
            }
        }
    }
}
