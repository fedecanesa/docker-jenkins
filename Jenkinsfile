pipeline {
    agent any
    stages {
        stage('Declarative: Checkout SCM') {
            steps {
                checkout scm
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("fedecanesa/mi-imagen:${BUILD_NUMBER}")
                }
            }
        }
        stage('Run Docker Container') {
            steps {
                script {
                    sh "docker run -d --entrypoint='/bin/sh' fedecanesa/mi-imagen:${BUILD_NUMBER} -c 'tail -f /dev/null'"
                }
            }
        }
        stage('Verificar contenedor') {
            steps {
                sh "docker ps -q"
            }
        }
    }
    post {
        always {
            sh "docker rmi -f fedecanesa/mi-imagen:${BUILD_NUMBER} || true"
        }
    }
}
