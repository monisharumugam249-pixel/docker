pipeline {
    agent any
    tools {
        maven 'maven3.9'
    }
    stages {
        stage('Checkout the code') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/monisharumugam249-pixel/docker.git'
            }
        }
        stage('Package the build') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }
       stage('Build Docker Image') {
    steps {
        sh 'docker build -t my-repo .'
         }
    }
        
        stage('Push and pull the image to the ECR and run the Container') {
            steps {
                sh '''

                # Stop and remove old container if exists
                docker rm -f my-app-container || true

                # Tag image with ECR repo path
                docker tag samplewebapp:latest 547268988607.dkr.ecr.ap-south-1.amazonaws.com/samplewebapp:latest

                # Push image to ECR
                docker push 547268988607.dkr.ecr.ap-south-1.amazonaws.com/samplewebapp:latest

                # Pull image back from ECR
                docker pull 547268988607.dkr.ecr.ap-south-1.amazonaws.com/samplewebapp:latest

                # Run new container
                docker run -d -p 8082:8080 --name my-tomcat-app-container3 \
                  547268988607.dkr.ecr.ap-south-1.amazonaws.com/samplewebapp
                '''
            }
        }
    }
}
