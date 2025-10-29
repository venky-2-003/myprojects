pipeline {
    agent any

    environment {
        APP_NAME = "hackthon"
        DOCKER_IMAGE = "hackthon:latest"
        // If you want to push to DockerHub, set your repo like:
        // DOCKER_REPO = "your-dockerhub-username/hackthon"
    }

    stages {
        stage('Checkout') {
            steps {
                // Pull code from SCM (GitHub/GitLab etc.)
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo "Building Docker image..."
                    sh "docker build -t ${DOCKER_IMAGE} ."
                }
            }
        }

        stage('Run Container (Test)') {
            steps {
                script {
                    echo "Running container for testing..."
                    sh "docker run -d --rm -p 8087:80 --name ${APP_NAME}_container ${DOCKER_IMAGE}"
                    // Wait for container to start
                    sh "sleep 5"
                    // Simple check to see if index.html is present
                    sh "docker exec ${APP_NAME}_container ls /usr/share/nginx/html"
                    // Stop the test container
                    sh "docker stop ${APP_NAME}_container"
                }
            }
        }

        // Optional: Push to DockerHub
        /*
        stage('Push to DockerHub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-credentials-id') {
                        sh "docker tag ${DOCKER_IMAGE} ${DOCKER_REPO}:latest"
                        sh "docker push ${DOCKER_REPO}:latest"
                    }
                }
            }
        }
        */
    }

    post {
        always {
            echo "Cleaning up unused Docker resources..."
            sh "docker system prune -f || true"
        }
        success {
            echo "✅ Build & Test successful for ${APP_NAME}"
        }
        failure {
            echo "❌ Build failed!"
        }
    }
}

