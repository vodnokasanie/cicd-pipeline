pipeline {
    agent any

    environment {
        // Ensure Jenkins sees Homebrew Node and Docker
        PATH = "/usr/local/bin:/opt/homebrew/bin:$PATH"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Install dependencies') {
            steps {
                sh 'npm install'
            }
        }

        stage('Test') {
            steps {
                sh 'npm test'
            }
        }

        stage('Build Docker image') {
            steps {
                sh 'docker build -t nodedev:v1.0 .'
            }
        }

        stage('Run container') {
            steps {
                sh 'docker run -d --name nodedev nodedev:v1.0'
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished.'
        }
    }
}
