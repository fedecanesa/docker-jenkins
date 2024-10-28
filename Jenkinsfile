pipeline {
    environment {
        IMAGEN = "fedecanesa/mi-imagen"  // Nombre del repositorio en DockerHub
        DOCKER_CREDENTIALS_ID = 'ID_CREDENCIALES_JENKINS'  // Credenciales creadas en Jenkins
    }
    agent any
    stages {
        stage('Clone') {
            steps {
                script {
                    echo "Clonando el repositorio desde GitHub..."
                    git branch: "main", url: 'https://github.com/fedecanesa/docker-jenkins.git'
                    echo "Repositorio clonado exitosamente."
                }
            }
        }
        stage('Build') {
            steps {
                script {
                    echo "Iniciando construcción de la imagen Docker..."
                    newApp = docker.build("${env.IMAGEN}:${env.BUILD_NUMBER}")
                    echo "Imagen Docker construida con etiqueta: ${env.IMAGEN}:${env.BUILD_NUMBER}"
                }
            }
        }
        stage('Test') {
            steps {
                script {
                    echo "Realizando pruebas en la imagen..."
                    docker.image("${env.IMAGEN}:${env.BUILD_NUMBER}").inside('-u root') {
                        sh 'echo "Prueba simulada: Ejecutando comandos de prueba en la imagen"'
                    }
                    echo "Pruebas completadas."
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    echo "Iniciando despliegue a Docker Hub..."
                    docker.withRegistry('', env.DOCKER_CREDENTIALS_ID) {
                        newApp.push()
                    }
                    echo "Despliegue a Docker Hub completado con éxito."
                }
            }
        }
        stage('Clean Up') {
            steps {
                script {
                    echo "Limpiando imagen local..."
                    sh "docker rmi ${env.IMAGEN}:${env.BUILD_NUMBER} || true"
                    echo "Imagen local eliminada."
                }
            }
        }
    }
    post {
        always {
            script {
                echo "Pipeline completado. Verifica los logs de cada etapa para más detalles."
            }
        }
    }
}
