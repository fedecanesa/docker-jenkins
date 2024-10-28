pipeline {
    agent any
    stages {

        stage('Declarative: Checkout SCM') {
            steps {
                checkout([
                    $class: 'GitSCM',
                    branches: [[name: '*/main']],
                    userRemoteConfigs: [[
                        url: 'git@github.com:fedecanesa/docker-jenkins.git',
                        credentialsId: 'dockerhub-credentials-id'
                    ]]
                ])
            }
        }
        
        stage('Debug Docker Installation') {
            steps {
                script {
                    // Comando de debug para verificar si Docker está instalado y accesible
                    sh 'docker --version || echo "Docker no está disponible"'
                    sh 'docker info || echo "No se puede acceder a Docker"'
                }
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
                sh "docker ps -q"
            }
        }
    }
    
    post {
        always {
            // Opcional: Limpieza de imágenes, pero sin eliminar el contenedor
            sh "docker rmi -f fedecanesa/mi-imagen:${BUILD_NUMBER} || true"
        }
    }
}
