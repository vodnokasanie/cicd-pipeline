pipeline {
    agent any

    
    environment {
        PATH = "/opt/homebrew/opt/node@20/bin:/opt/homebrew/bin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin:$PATH"
    }
    

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Install dependencies') {
            steps {

                sh '''#!/bin/bash
                    node --version
                    npm --version
                    npm install
                '''

            }
        }
        
        stage('Test') {
            steps {

                sh '''#!/bin/bash
                    npm test
                '''
            }
        }
        
        stage('Build Docker image') {
            steps {
                script {
                    def branch = env.BRANCH_NAME ?: 'dev'
                    def imageName = branch == 'main' ? 'nodemain:v1.0' : 'nodedev:v1.0'
                    sh """#!/bin/bash
                        docker build -t ${imageName} .
                    """
                }
            }
        }
        
        stage('Run container') {
            steps {
                script {
                    def branch = env.BRANCH_NAME ?: 'dev'
                    def containerName = branch == 'main' ? 'nodemain' : 'nodedev'
                    def imageName = branch == 'main' ? 'nodemain:v1.0' : 'nodedev:v1.0'
                    def port = branch == 'main' ? '3000' : '3001'
                    
                    sh """#!/bin/bash
                        docker stop ${containerName} 2>/dev/null || true
                        docker rm ${containerName} 2>/dev/null || true
                        docker run -d --name ${containerName} --expose ${port} -p ${port}:3000 ${imageName}
                    """
                }
            }
        }
    }
    
    post {
        always {
            echo 'Pipeline finished.'
        }
        failure {
            echo 'Pipeline failed!'
        }
        success {
            echo 'Pipeline succeeded!'
        }
    }
}