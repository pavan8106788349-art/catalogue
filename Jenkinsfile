pipeline {
    agent {
        node {
            label 'roboshop'
        }
    }

    environment {
        appVersion = "1.0"
    }

    options {
        disableConcurrentBuilds()
        timeout(time: 5, unit: 'MINUTES')
    }

    stages {

        stage('Read Version') {
            steps {
                script {
                    def packageJson = readJSON file: 'package.json'
                    env.appVersion = packageJson.version
                    echo "App version is ${env.appVersion}"
                }
            }
        }

        stage('Install dependencies') {
            steps {
                sh """
                    npm install
                """
            }
        }

        stage('Build docker image') {
            steps {
                sh """
                    docker build -t catalogue:${env.appVersion} .
                """
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished'
        }
        success {
            echo "pipeline success"
        }
        failure {
            echo "pipeline failure"
        }
    }
}


