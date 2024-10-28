pipeline {
    environment {
        IMAGEN = "fedecanesa/mi-imagen"  // DockerHub repository name
        DOCKER_CREDENTIALS_ID = 'ID_CREDENCIALES_JENKINS'  // Jenkins credentials ID
    }
    agent any
    stages {
        stage('Clone') {
            steps {
                script {
                    echo "Cloning the repository from GitHub..."
                    git branch: "main", url: 'https://github.com/fedecanesa/docker-jenkins.git'
                    echo "Repository successfully cloned."
                }
            }
        }
        stage('Build') {
            steps {
                script {
                    echo "Starting Docker image build..."
                    newApp = docker.build("${env.IMAGEN}:${env.BUILD_NUMBER}")
                    echo "Docker image built with tag: ${env.IMAGEN}:${env.BUILD_NUMBER}"
                }
            }
        }
        stage('Test') {
            steps {
                script {
                    echo "Running tests on the Docker image..."
                    docker.image("${env.IMAGEN}:${env.BUILD_NUMBER}").inside('-u root') {
                        sh 'echo "Simulated Test: Running test commands in the image"'
                    }
                    echo "Tests completed."
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    echo "Starting deployment to Docker Hub..."
                    docker.withRegistry('', env.DOCKER_CREDENTIALS_ID) {
                        newApp.push()
                    }
                    echo "Successfully deployed to Docker Hub."
                }
            }
        }
        stage('Clean Up') {
            steps {
                script {
                    echo "Cleaning up local image..."
                    sh "docker rmi ${env.IMAGEN}:${env.BUILD_NUMBER} || true"
                    echo "Local image removed."
                }
            }
        }
    }
    post {
        always {
            script {
                echo "Pipeline completed. Check each stage's logs for details."
            }
        }
    }
}
