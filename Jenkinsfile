pipeline {
    agent any
    stages {
        stage('Checkout the code') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/monisharumugam249-pixel/docker'
            }
        }
        stage('Package the build') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }
    environment {
        AWS_REGION = 'ap-south-1'
        ECR_REPO   = '547268988607.dkr.ecr.ap-south-1.amazonaws.com/samplewebapp'
        IMAGE_TAG  = "${BUILD_NUMBER}"
    }
    stages {
        stage('Build') {
            steps {
                sh 'docker build -t samplewebapp:${IMAGE_TAG} .'
            }
        }
        stage('Push to ECR and run') {
            steps {
                sh '''
                    aws ecr get-login-password --region $AWS_REGION | \
                      docker login --username AWS --password-stdin 547268988607.dkr.ecr.ap-south-1.amazonaws.com

                    docker tag samplewebapp:${IMAGE_TAG} $ECR_REPO:${IMAGE_TAG}
                    docker tag samplewebapp:${IMAGE_TAG} $ECR_REPO:latest
                    docker push $ECR_REPO:${IMAGE_TAG}
                    docker push $ECR_REPO:latest

                    docker rm -f my-app-container || true
                    docker run -d --name my-app-container -p 8081:8080 547268988607.dkr.ecr.ap-south-1.amazonaws.com/samplewebapp:latest
                '''
            }
        }
    }
}
