pipeline {
    agent any
    
    environment {
        PATH = "/usr/local/bin:/opt/homebrew/bin:/bin:/usr/bin:/sbin:/usr/sbin:$PATH"
        // Add NODE_HOME if you configured Node in Global Tool Configuration
        // NODE_HOME = tool name: 'NodeJS-7.8.0', type: 'NodeJSInstallation'
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Install dependencies') {
            steps {
                script {
                    sh '#!/bin/bash\nnpm install'
                }
            }
        }
        
        stage('Test') {
            steps {
                script {
                    sh '#!/bin/bash\nnpm test'
                }
            }
        }
        
        stage('Build Docker image') {
            steps {
                script {
                    def branch = env.BRANCH_NAME ?: 'dev'
                    def imageName = branch == 'main' ? 'nodemain:v1.0' : 'nodedev:v1.0'
                    sh "#!/bin/bash\ndocker build -t ${imageName} ."
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
                    
                    // Stop and remove existing container (minimize downtime)
                    sh """#!/bin/bash
                        docker stop ${containerName} || true
                        docker rm ${containerName} || true
                    """
                    
                    // Run new container
                    sh """#!/bin/bash
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