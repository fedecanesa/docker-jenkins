pipeline {
    environment {
        IMAGEN = "fedecanesa/mi-imagen-docker"  // Reemplaza con tu repositorio
        DOCKER_CREDENTIALS_ID = 'ID_CREDENCIALES_JENKINS'  // Reemplaza con el ID que usaste para las credenciales en Jenkins
    }
    agent any
    stages {
        stage('Clone') {
            steps {
                script {
                    git branch: "main", url: 'https://github.com/fedecanesa/docker-jenkins.git'  // Cambia al repositorio que deseas clonar
                }
            }
        }
        stage('Build') {
            steps {
                script {
                    newApp = docker.build "${env.IMAGEN}:${env.BUILD_NUMBER}"
                }
            }
        }
        stage('Test') {
            steps {
                script {
                    docker.image("${env.IMAGEN}:${env.BUILD_NUMBER}").inside('-u root') {
                        sh 'apache2ctl -v'  // Cambia este comando si necesitas ejecutar otros tests
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    docker.withRegistry('', env.DOCKER_CREDENTIALS_ID) {
                        newApp.push()
                    }
                }
            }
        }
        stage('Clean Up') {
            steps {
                script {
                    sh "docker rmi ${env.IMAGEN}:${env.BUILD_NUMBER}"
                }
            }
        }
    }
}
