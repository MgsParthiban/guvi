pipeline {
    agent any
    environment {
        DOCKER_HUB_CREDENTIALS = credentials('docekr-hub')
        BUILD_NUMBER = "${env.BUILD_NUMBER}" // Provided automatically by Jenkins
    }
    stages {
        stage('Build Docker Image') {
            steps {
                sh '''
                # Define the image name
                IMAGE_NAME=Myapp
                
                # Provide the execute permission
                chmod +x build.sh

                # Call the build.sh script with the image name
                ./build.sh $IMAGE_NAME
                '''
            }
        }
    }
}
