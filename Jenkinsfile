pipeline {
    agent any
    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("fedecanesa/mi-imagen:${env.BUILD_ID}")
                }
            }
        }
        stage('Run Docker Container') {
            steps {
                script {
                    def containerID = docker.image("fedecanesa/mi-imagen:${env.BUILD_ID}").run('-d')
                    env.CONTAINER_ID = containerID.trim()
                }
            }
        }
        stage('Verificar contenedor') {
            steps {
                script {
                    sh "docker exec ${env.CONTAINER_ID} ps aux"
                }
            }
        }
        stage('Capturar logs del contenedor') {
            steps {
                script {
                    sh "docker logs ${env.CONTAINER_ID} > logs.txt"
                    archiveArtifacts artifacts: 'logs.txt'
                }
            }
        }
        stage('Push Docker Image to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-credentials-id') {
                        docker.image("fedecanesa/mi-imagen:${env.BUILD_ID}").push()
                    }
                }
            }
        }
    }
    post {
        always {
            script {
                sh "docker rm -f ${env.CONTAINER_ID}"
            }
        }
    }
}
