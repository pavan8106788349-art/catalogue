pipeline {
    agent {
        node {
            label 'roboshop'
        }
    }

    environment {
        appVersion = "1.0"
        ACC_ID = "593300579669"
        REGION = "us-east-1"
        REPO = "roboshop/catalogue"
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
                sh 'npm install'
            }
        }

        stage('Build & Push Docker Image') {
            steps {
                script {

                    sh """
                        aws ecr get-login-password --region ${REGION} | docker login --username AWS --password-stdin ${ACC_ID}.dkr.ecr.${REGION}.amazonaws.com
                    """

                    sh """
                        docker build -t ${REPO}:${appVersion} .
                    """

                    sh """
                        docker tag ${REPO}:${appVersion} ${ACC_ID}.dkr.ecr.${REGION}.amazonaws.com/${REPO}:${appVersion}
                    """

                    sh """
                        docker push ${ACC_ID}.dkr.ecr.${REGION}.amazonaws.com/${REPO}:${appVersion}
                    """
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished'
        }
        success {
            echo 'pipeline success'
        }
        failure {
            echo 'pipeline failure'
        }
    }
}

