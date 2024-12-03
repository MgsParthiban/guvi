pipeline {
    agent any
    environment {
        DOCKER_HUB_CREDENTIALS = credentials('docker-hub') // Corrected credentials ID
        IMAGE_NAME = "mydev"
        DOCKER_IMAGE_NAME = "parthitk/task" // Unique tag with Jenkins build number
        DOCKER_TAG = "${DOCKER_IMAGE_NAME}:${BUILD_NUMBER}"
        DOCKER_HUB_IMAGE = "parthitk/task:6"
        SSH_KEY = credentials('SSH_KEY') 
    }
    parameters {
       choice(name: 'ENVIRONMENT', choices: ['Dev', 'Prod'], description: 'Choose the environment to deploy to')
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
                    ./build.sh "${DOCKER_IMAGE_NAME}"
                    '''
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', "docker-hub") {
                        sh "docker push ${DOCKER_TAG}"
                        echo" image successfully pushed into the docker hub"
                    }
                }
            }
        }
        stage('Deploy to UAT') {
            steps {
                script {
                    echo "Deploying to UAT environment on EC2 instance..."
                    def ec2Ip = (params.ENVIRONMENT == 'Prod') ? env.PROD : env.UAT 
                    // Use `sshagent` to access the stored SSH key securely
                    sshagent(['SSH_KEY']) {
                        sh """
                            ssh -o StrictHostKeyChecking=no ubuntu@${ec2Ip} '
                                chmod +x deploy.sh
                                ./deploy.sh ${DOCKER_HUB_IMAGE}
                                
                            '
                        """
                    }
                }
            }
        }
    }
}
