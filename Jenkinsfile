pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Install dependencies') {
            steps {
                // prepend PATH just for this step
                withEnv(["PATH=/usr/local/bin:/opt/homebrew/bin:$PATH"]) {
                    sh 'npm install'
                }
            }
        }

        stage('Test') {
            steps {
                withEnv(["PATH=/usr/local/bin:/opt/homebrew/bin:$PATH"]) {
                    sh 'npm test'
                }
            }
        }

        stage('Build Docker image') {
            steps {
                withEnv(["PATH=/usr/local/bin:/opt/homebrew/bin:$PATH"]) {
                    sh 'docker build -t nodedev:v1.0 .'
                }
            }
        }

        stage('Run container') {
            steps {
                withEnv(["PATH=/usr/local/bin:/opt/homebrew/bin:$PATH"]) {
                    sh 'docker run -d --name nodedev nodedev:v1.0'
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished.'
        }
    }
}
