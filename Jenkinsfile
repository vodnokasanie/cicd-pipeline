pipeline {
    agent any

    environment {
        // Add NodeJS bin to PATH without overwriting PATH
        PATH = "/opt/homebrew/opt/node@20/bin:${env.PATH}"
    }

    stages {

        stage('Checkout SCM') {
            steps {
                checkout scm
            }
        }

        stage('Install dependencies') {
            steps {
                // Use PATH+NODE so Jenkins won't break sh
                withEnv(["PATH+NODE=/opt/homebrew/opt/node@20/bin:$PATH"]) {
                    sh 'node -v'
                    sh 'npm -v'
                    sh 'npm install'
                }
            }
        }

        stage('Test') {
            steps {
                withEnv(["PATH+NODE=/opt/homebrew/opt/node@20/bin:$PATH"]) {
                    sh 'npm test'
                }
            }
        }

        stage('Build Docker image') {
            steps {
                // Make sure docker is installed and in PATH
                sh 'docker build -t nodedev:v1.0 .'
            }
        }

        stage('Run container') {
            steps {
                sh 'docker run -d --name nodedev_container nodedev:v1.0'
            }
        }
    }
    
    post {
        always {
            echo 'Pipeline finished.'
        }
    }
}
