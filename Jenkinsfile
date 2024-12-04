pipeline {
    agent any
    environment {
        DOCKER_HUB_CREDENTIALS = credentials('docker-hub') // Corrected credentials ID
        IMAGE_NAME = "mydev"
        DOCKER_IMAGE_NAME = "parthitk/task" // Unique tag with Jenkins build number
        DOCKER_TAG = "${DOCKER_IMAGE_NAME}:${BUILD_NUMBER}"
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
                    def ec2Ip = env.PROD
                    // Use `sshagent` to access the stored SSH key securely
                    sshagent(['SSH_KEY']) {
                        sh """
                            scp -o StrictHostKeyChecking=no deploy.sh .env docker-compose.yml secret.txt ubuntu@${ec2Ip}:~/
                            ssh -o StrictHostKeyChecking=no ubuntu@${ec2Ip} '
                                echo "${DOCKER_HUB_CREDENTIALS_PSW}" | docker login -u "${DOCKER_HUB_CREDENTIALS_USR}"
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
