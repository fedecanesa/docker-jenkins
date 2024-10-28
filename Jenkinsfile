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
                    def container = docker.image("fedecanesa/mi-imagen:${env.BUILD_ID}")
                    env.CONTAINER_ID = container.run('--entrypoint tail -- -f /dev/null').id
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
                // Verifica que el contenedor existe antes de intentar eliminarlo
                sh 'docker ps -q | grep -w ${CONTAINER_ID} && docker rm -f ${CONTAINER_ID} || echo "Contenedor no encontrado o ya eliminado."'
            }
        }
    }
}
