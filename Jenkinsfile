pipeline {
    agent any

    tools {
        nodejs "node18"
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
                script {
                    if (env.BRANCH_NAME == 'main') {
                        sh 'docker build -t nodemain:v1.0 .'
                    } else if (env.BRANCH_NAME == 'dev') {
                        sh 'docker build -t nodedev:v1.0 .'
                    }
                }
            }
        }

        stage('Run container') {
            steps {
                script {
                    sh '''
                    docker ps -q | xargs -r docker stop
                    docker container prune -f
                    if [ "$BRANCH_NAME" = "main" ]; then
                        docker run -d --expose 3000 -p 3000:3000 nodemain:v1.0
                    else
                        docker run -d --expose 3001 -p 3001:3000 nodedev:v1.0
                    fi
                    '''
                }
            }
        }
    }
}
