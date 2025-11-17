pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "yosrguermazi/mon-app:latest"
    }

    stages {

        stage('Cloner') {
            steps {
                git url: 'https://github.com/yosrguermazi/mon-app.git'
            }
        }

        stage('Build Docker') {
            steps {
                sh """
                    docker build -t ${DOCKER_IMAGE} .
                """
            }
        }

        stage('Push Docker') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'dockerhub-creds',
                        usernameVariable: 'DOCKER_USERNAME',
                        passwordVariable: 'DOCKER_PASSWORD'
                    )
                ]) {
                    sh """
                        echo \$DOCKER_PASSWORD | docker login -u \$DOCKER_USERNAME --password-stdin
                        docker push ${DOCKER_IMAGE}
                    """
                }
            }
        }

        stage('Deploy Kubernetes') {
            steps {
                sh "kubectl apply -f k8s/deployment.yaml"
                sh "kubectl apply -f k8s/service.yaml"
            }
        }
    }
}
