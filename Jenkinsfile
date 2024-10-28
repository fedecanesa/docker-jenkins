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
                    // Aquí colocamos el ajuste para correr el contenedor
                    sh "docker run -d --entrypoint='/bin/sh' fedecanesa/mi-imagen:${BUILD_NUMBER} -c 'tail -f /dev/null'"
                }
            }
        }
        stage('Verificar contenedor') {
            steps {
                // Aquí puedes agregar la lógica para verificar el contenedor
                sh "docker ps | grep fedecanesa/mi-imagen:${BUILD_NUMBER}"
            }
        }
    }
    post {
        always {
            sh "docker rmi -f fedecanesa/mi-imagen:${BUILD_NUMBER} || true"
        }
    }
}
