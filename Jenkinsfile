pipeline {
    agent {
        node {
            label 'ROBOSHOP'
        }
    }

    environment {
        appVersion = ""
    }

    options {
        timeout(time: 5, unit: 'MINUTES')
    }  

    stages {
        stage('Read version') {
            steps {
                script {
                    def packageJson = readJSON file: 'package.json'
                    appVersion = packageJson.version
                    echo "Building version ${appVersion}"
                }
            }    
        }

        stage('Install dependencies') { 
            steps {
                script {
                    sh 'npm install'
                }
            }
        }

        stage('Build Image') { 
            steps {
                script {
                    sh """
                      docker build -t catalogue:${appVersion} .
                    """
                }
            }
        }

        stage('Deploy') {
            when {
                expression { params.DEPLOY == true }
            }
            steps {
                script {
                    sh 'echo "Deploying"'
                }
            }
        }
    }

    post { 
        always { 
            echo 'I will always say Hello again!'
        }
        success {
            echo "pipeline success"
        }
        failure {
            echo "pipeline failure"
        }
    }
}